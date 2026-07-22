//
//  ProductOptionValueCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 18/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionValueFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @Bindable
    var value: ProductOptionValue

    var body: some View {
        Form {
            TextField("Requis", text: $value.name)

            if value.hasChanges {
                Text("CHANGES")
            }
        }
    }
}
