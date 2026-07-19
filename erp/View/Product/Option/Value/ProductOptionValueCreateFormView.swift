//
//  ProductOptionValueCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 18/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionValueCreateFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @Bindable
    var value: ProductOptionValue

    var body: some View {
        Form {
            TextField("Requis", text: $value.name)
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(role: .cancel) {
                    dismiss()
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Créer") {
                    create()
                }
                .disabled(value.name.isEmpty)
            }
        }
    }

    // TODO: Create a envrionment create() to pass the object back ?
    private func create() {
        value.option?.values.append(value)
    }
}
