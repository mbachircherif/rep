//
//  DeleteAction.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

struct DeleteAction {

    private var action: () -> Void

    init(_ action: @escaping () -> Void) {
        self.action = action
    }

    func callAsFunction() {
        action()
    }
}
