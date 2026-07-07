//
//  TaskState.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 07/07/2026.
//

import Observation
import Synchronization

enum TaskState<Success, Failure> where Success : Sendable, Failure: Error {

    case idle

    case loading(Task<Success, Failure>)

    case success(Task<Success, Failure>, Success)

    case failure(Task<Success, Failure>, Failure)
}
