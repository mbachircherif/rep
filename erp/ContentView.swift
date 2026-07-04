//
//  ContentView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.assistant)
    private var assistant

    @Environment(\.modelContext)
    private var modelContext

    @Query private var items: [Item]

    @State
    private var prompt: String = ""

    @State
    private var demandTask: Task<Void, Error>?

    @State
    private var recorder = SpeechRecorderManager()

    enum LoadingPhase {

        case idle

        case loading

        case success

        case failure
    }

    @State
    private var demandLoadingState: LoadingPhase = .idle

    @State
    private var toggleRecordingTask: Task<Void, Error>?

    @State
    private var toggleRecordingLoadingState: LoadingPhase = .idle

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .safeAreaBar(edge: .bottom) {
                HStack {
                    TextField("Formulez votre demande", text: $prompt)

                    if prompt.isEmpty {
                        Button {
                            toggleRecordingTask = Task { try await recorder.toggle() }
                        } label: {
                            Image(systemName: recorder.isRecording ? "stop.circle.fill" : "microphone.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.black)
                        }
                        .disabled(toggleRecordingLoadingState == .loading)
                        .task(id: toggleRecordingTask) {
                            guard let toggleRecordingTask else { return }

                            toggleRecordingLoadingState = .loading

                            do {
                                try await toggleRecordingTask.value
                                print("Toggle Recording Success")
                                toggleRecordingLoadingState = .success
                            } catch {
                                print("Toggle Recording Failure \(error)")
                                toggleRecordingLoadingState = .failure
                            }
                        }
                    } else {
                        Button {
                            demandTask = Task { try await assistant.send(demand: prompt) }
                        } label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(12.0)
                .frame(height: 48.0)
                .glassEffect(.regular, in: .capsule)
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .task(id: demandTask) {
                guard let demandTask else { return }

                print("Start Demand")
                demandLoadingState = .loading

                switch await withResultOperation({ try await demandTask.value }) {
                case .success:
                    print("Success Demand")
                    demandLoadingState = .success
                case .failure(let error):
                    print("Failure Demand \(error)")
                    demandLoadingState = .failure
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
