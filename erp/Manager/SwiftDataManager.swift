//
//  SwiftDataManager.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import SwiftData

@Observable
final class SwiftDataManager {

    private let model: ModelContainer

    init(model: ModelContainer) {
        self.model = model
    }

    @MainActor
    func transaction(_ block: @escaping () throws -> Void) throws {
        try model.mainContext.transaction(block: block)
    }
}
