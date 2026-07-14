//
//  Extension+View.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import SwiftUI

extension View {

    func onDelete(_ action: @escaping () -> Void) -> some View {
        environment(\.delete, DeleteAction(action))
    }
}
