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

    func newContext(autosave: Bool = false) -> ModelContext {
        let context = ModelContext(container)

        context.autosaveEnabled = autosave

        return context
    }

    convenience init(_ container: ModelContainer, autosave: Bool = false) {
        self.init(container)
        self.autosaveEnabled = autosave
    }
}
