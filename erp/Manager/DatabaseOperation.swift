//
//  DatabaseOperation.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 07/07/2026.
//

import SwiftData

enum DataOperationAction {

    case insert(any PersistentModel)

    case update(any PersistentModel)

    case delete(any PersistentModel)
}
