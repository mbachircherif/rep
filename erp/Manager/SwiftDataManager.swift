//
//  SwiftDataManager.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import SwiftData
import Foundation

typealias SendableAsyncSequence<T> = AsyncSequence<T, Never> & Sendable

@globalActor actor SyncActor {
    public static let shared = SyncActor()

    private init() { }
}

@Observable
@SyncActor
final class SwiftDataManager: Sendable {

    let context: ModelContext

    private let stream = AsyncSharedStream<HistoryChange>()

    private var lastToken: DefaultHistoryToken?

    init(container: ModelContainer) {
        print("INIT SWIFT DATA MANAGER")
        let context = ModelContext(container)

        context.author = "SwiftDataManager"
        context.autosaveEnabled = false

        self.context = context
    }

    func insert<T>(_ model: T) where T : PersistentModel {
        context.insert(model)
    }

    func save() throws {
        try context.save()
    }

    func unsafeSave() {
        try? context.save()
    }

    func sync() {

        let descriptor: HistoryDescriptor<DefaultHistoryTransaction>

        if let lastToken = lastToken {
            descriptor = HistoryDescriptor<DefaultHistoryTransaction>(predicate: #Predicate { transaction in transaction.token > lastToken })
        } else {
            descriptor = HistoryDescriptor<DefaultHistoryTransaction>()
        }

        do {
            let history = try context.fetchHistory(descriptor)

            for transaction in history {
                for change in transaction.changes {
                    stream.send(change)
                }
            }

            if let latestToken = history.last?.token {
                lastToken = latestToken
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel {
        try context.fetch(descriptor)
    }

    func fetch(for id: PersistentIdentifier) -> any PersistentModel {
        context.model(for: id)
    }

    func changes() -> any SendableAsyncSequence<HistoryChange> {
        stream.shared
    }
}
