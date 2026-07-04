//
//  SpeechRecorderManager.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

@preconcurrency import AVFAudio
import Speech
import Observation
import Synchronization

@Observable
final class SpeechRecorderManager: Sendable {

    let audioEngine = AVAudioEngine()
    let mixerNode = AVAudioMixerNode()

    private var transcriber: SpeechTranscriber?

    private(set) var isRecording: Bool = false

    private let audioBuffer: Mutex<[AVAudioPCMBuffer]> = .init([])

    func toggle() async throws {
        if isRecording {
            try await stop()
        } else {
            try await start()
        }
    }

    @MainActor
    func start() async throws {
        defer {
            isRecording = true
        }

        // Ask for permission
        guard await AVAudioApplication.requestRecordPermission() else {
            throw SpeechRecorderError.notAllowedToRecord
        }

        guard let locale = await SpeechTranscriber.supportedLocale(equivalentTo: .init(identifier: "fr_FR")) else {
            throw SpeechRecorderError.localeNotSupported
        }

        // Create transcriber
        let transcriber = SpeechTranscriber(locale: locale, preset: .transcription)
        self.transcriber = transcriber

        if let assetDownloader = try await AssetInventory.assetInstallationRequest(supporting: [transcriber]) {
            print("Downloading and installing asset...", locale)
            try await assetDownloader.downloadAndInstall()
        }

        // Create audio session
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.record, mode: .default)
        try session.setActive(true, options: .notifyOthersOnDeactivation)

        let inputNode = audioEngine.inputNode

        // Install a tap on the mixer node to capture the microphone audio.
        inputNode.installTap(onBus: 0, bufferSize: 4096, format: inputNode.inputFormat(forBus: 0)) { [weak self] buffer, audioTime in
            // Add captured audio to the buffer used for making a match.
            self?.audioBuffer.withLock { $0.append(buffer) }
        }

        audioEngine.prepare()
        try audioEngine.start()
    }

    @MainActor
    func stop() async throws {

        audioEngine.inputNode.removeTap(onBus: 0)

        audioEngine.stop()

        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

        let audioBuffer = audioBuffer.withLock { $0 }

        guard let transcriber, !audioBuffer.isEmpty else { return }

        guard let bestTranscriberFormat = await SpeechAnalyzer.bestAvailableAudioFormat(compatibleWith: [transcriber]) else {
            throw SpeechRecorderError.bestAvailableFormatNotFound
        }

        let analyzer = SpeechAnalyzer(modules: [transcriber])

        // Collect results while feeding the stored buffers.
        let (inputSequence, inputBuilder) = AsyncStream<AnalyzerInput>.makeStream()

        try await analyzer.start(inputSequence: inputSequence)

        // Replay the record for analysis
        for buffer in audioBuffer {
            var buffer = {
                if buffer.format != bestTranscriberFormat {
                    let converter = AVAudioConverter(from: buffer.format, to: bestTranscriberFormat)
                    let ratio = bestTranscriberFormat.sampleRate / buffer.format.sampleRate
                    let capacity = AVAudioFrameCount(Double(buffer.frameLength) * ratio) + 1

                    guard let output = AVAudioPCMBuffer(pcmFormat: bestTranscriberFormat, frameCapacity: capacity) else {
                        throw SpeechRecorderError.formatConversionFailed
                    }

                    var error: NSError?
                    var consumed = false

                    converter?.convert(to: output, error: &error) { packetCount, inputStatus in
                        print(packetCount)
                        if consumed {
                            inputStatus.pointee = .noDataNow
                            return nil
                        }
                        consumed = true
                        inputStatus.pointee = .haveData
                        return buffer
                    }

                    if let error { throw error }

                    return output
                } else {
                    return buffer
                }
            }

            inputBuilder.yield(AnalyzerInput(buffer: try buffer()))
        }

        inputBuilder.finish()

        try await analyzer.finalizeAndFinishThroughEndOfInput()

        print(try await transcriber.results.reduce(AttributedString()) { partial, result in partial + result.text } )

        isRecording = false
    }
}

enum SpeechRecorderError: Error {

    case notAllowedToRecord

    case localeNotSupported

    case bestAvailableFormatNotFound

    case formatConversionFailed
}
