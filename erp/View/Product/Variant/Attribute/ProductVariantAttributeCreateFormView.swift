//
//  ProductVariantAttributeCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData
import SwiftUI

struct ProductVariantAttributeCreateFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var key: String = ""

    @State
    private var value: String = ""

    var variant: ProductVariant

    var body: some View {
        Form {
            TextField("Name", text: $key)
            TextField("Valeur", text: $value)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
//                    variant.attributes.append(ProductVariantAttribute(variant: variant, kind: kind, key: key, value: value))
                    dismiss()
                }
            }
        }
    }
}
