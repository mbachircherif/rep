//
//  Extension+ModelContext.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData

extension ModelContext {

    static func appContext(_ container: ModelContainer) -> ModelContext {
        let context = ModelContext(container)

        context.author = "erp"
        context.autosaveEnabled = true

        return context
    }
}
