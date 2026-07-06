//
//  View+onTransactionChanges.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 06/07/2026.
//

import Combine
import SwiftData
import SwiftUI

struct TransactionObserverViewMofidier<Model>: ViewModifier where Model : PersistentModel {

    @Environment(SwiftDataManager.self)
    private var database

    let action: (HistoryChange) -> Void

    func body(content: Content) -> some View {
        content
            .task(priority: .background) {
                for await change in await database.changes(for: Model.self) {
                    action(change)
                }
            }
    }
}

extension View {

    func onTransactionChanges<Model>(perform action: @escaping (HistoryChange) -> Void) -> some View where Model : PersistentModel {
        modifier(TransactionObserverViewMofidier<Model>(action: action))
    }
}
