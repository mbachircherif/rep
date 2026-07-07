//
//  View+onTransactionChanges.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 06/07/2026.
//

import Combine
import SwiftData
import SwiftUI

struct TransactionObserverViewMofidier: ViewModifier {

    @Environment(SwiftDataManager.self)
    private var database

    let action: (DataOperationAction) -> Void

    func body(content: Content) -> some View {
        content
            .task(priority: .background) {
                for await change in await database.changes() {
                    let model = await database.fetch(for: change.changedPersistentIdentifier)

                    switch change {
                    case .delete:
                        action(.delete(model))
                    case .insert:
                        action(.insert(model))
                    case .update:
                        action(.update(model))
                    @unknown default:
                        break
                    }
                }
            }
    }
}

extension View {

    func onTransactionChanges(perform action: @escaping (DataOperationAction) -> Void) -> some View {
        modifier(TransactionObserverViewMofidier(action: action))
    }
}
