//
//  AsyncSharedStream.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 06/07/2026.
//

import AsyncAlgorithms

final class AsyncSharedStream<T> where T : Sendable {

    private let continuation: AsyncStream<T>.Continuation

    /// Track:
    /// -https://github.com/apple/swift-async-algorithms/issues/431
    /// -https://github.com/apple/swift-async-algorithms/pull/412
    let shared: any AsyncSequence<T, Never> & Sendable

    init() {
        let (stream, continuation) = AsyncStream.makeStream(of: T.self, bufferingPolicy: .unbounded)

        self.continuation = continuation
        self.shared = stream.share(bufferingPolicy: .unbounded)
    }

    func send(_ change: T) {
        continuation.yield(change)
    }
}
