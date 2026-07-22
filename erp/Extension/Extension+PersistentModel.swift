//
//  Extension+PersistentModel.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 19/07/2026.
//

import SwiftData

extension PersistentModel {

    var isPendingInserted: Bool {
        modelContext?.insertedModelsArray.contains { $0.id == persistentModelID } ?? false
    }

    var isPendingUpdated: Bool {
        modelContext?.changedModelsArray.contains { $0.id == persistentModelID } ?? false
    }

    var isPendingDeleted: Bool {
        modelContext?.deletedModelsArray.contains { $0.id == persistentModelID } ?? false
    }
}
