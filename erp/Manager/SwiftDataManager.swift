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

    private let context: ModelContext

    private var streams: [AnyMetatype : AsyncSharedStream<HistoryChange>] = [:]

    private var lastToken: DefaultHistoryToken?

    init(container: ModelContainer, observedModels: [any PersistentModel.Type]) {
        self.context = ModelContext(container)
    }

    func browseHistory() async {

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
                    switch change {
                    case .insert(let insert):
                        notifyInsertChange(insert)
                    case .update(let update):
                        notifyUpdateChange(update)
                    case .delete(let delete):
                        notifyDeleteChange(delete)
                    @unknown default:
                        break
                    }
                }
            }

            if let latestToken = history.last?.token {
                lastToken = latestToken
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func notifyInsertChange<Model>(_ existantial: some HistoryInsert<Model>) {
        if let stream = streams[AnyMetatype(Model.self)] {
            stream.send(.insert(existantial))
        }
    }

    private func notifyUpdateChange<Model>(_ existantial: some HistoryUpdate<Model>) {
        if let stream = streams[AnyMetatype(Model.self)] {
            stream.send(.update(existantial))
        }
    }

    private func notifyDeleteChange<Model>(_ existantial: some HistoryDelete<Model>) {
        if let stream = streams[AnyMetatype(Model.self)] {
            stream.send(.delete(existantial))
        }
    }

    func changes<Model: PersistentModel>(for model: Model.Type) -> any SendableAsyncSequence<HistoryChange> {
        streams[AnyMetatype(model), default: AsyncSharedStream()].shared
    }
}
