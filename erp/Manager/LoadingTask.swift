//
//  TaskSequencer.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 07/07/2026.
//

import Foundation


/// Runs operations strictly one at a time, in submission order.
/// Submitting a new operation cancels the previous one (cooperatively):
/// superseded operations are expected to exit early, and their results
/// are discarded — only the latest operation reports through `state`.
@MainActor @Observable
final class LoadingTask<Success, Failure> where Failure : Error {

    private var currentTask: Task<Void, Never>?

    enum State {

        case waiting, running, success(Success), failure(Failure)
    }

    var state: State = .waiting

    init(state: State) {
        self.state = state
    }

    // Since Swift 6.2
    isolated deinit {
        currentTask?.cancel()
    }

    func run(_ operation: @escaping @Sendable () async -> Result<Success, Failure>) {
        // 1. Cancel the previous task (cooperative — it may still be winding down)
        currentTask?.cancel()

        // 2. Bump the generation so stale tasks can't clobber our state
        let previousTask = currentTask

        currentTask = Task { [weak self] in
            await previousTask?.value

            // If the current task has not been cancelled while waiting the previous task to finish.
            guard Task.isCancelled == false else { return }

            self?.state = .running

            /// `await operation()` is this task's final suspension point: while suspended,
            /// the actor is released, and any queued work — including `cancel()` or a new
            /// `run()` — may execute and flip our cancellation flag.
            ///
            /// Once the operation resumes, the remainder of this task is synchronous, so it
            /// occupies the actor until it returns. A `cancel()` arriving now must wait its
            /// turn — by then the task has finished, and the flag is set too late to matter.
            let result = await operation()

            guard !Task.isCancelled else { return }

            switch result {
            case .success(let value): self?.state = .success(value)
            case .failure(let error): self?.state = .failure(error)
            }
        }
    }

    func cancel() {
        currentTask?.cancel()
        currentTask = nil

        state = .waiting
    }
}
