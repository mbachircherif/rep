//
//  AttributeFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftUI

struct AttributeFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(SwiftDataManager.self)
    private var db

    @State
    private var attributeKind: AttributeKind = .color

    @State
    private var key: String = ""

    @State
    private var value: String = ""

    var variant: ProductVariant

    var body: some View {
        Form {
            Picker("Kind", selection: $attributeKind) {
                Text("Color")
                    .tag(AttributeKind.color)

                Text("Custom")
                    .tag(AttributeKind.custom)
            }

            if attributeKind == .custom {
                TextField("Name", text: $key)
            }

            if attributeKind == .color {
                ColorPicker("Color", selection: Binding(get: { Color(hex: value) ?? .white }, set: { value = $0.toHex(includeAlpha: false) ?? "" }))
            } else {
                TextField("Valeur", text: $value)
            }
        }
        .onChange(of: attributeKind) { _, newValue in
            switch newValue {
            case .color:
                key = "Color"
            default:
                key = ""
            }

            value = ""
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    variant.attributes.append(ProductVariantAttribute(variant: variant, key: key, value: value))
                    dismiss()
                }
            }
        }
        .onAppear {
            switch attributeKind {
            case .color:
                key   = "Color"
                value = "#000000"
            case .custom:
                key   = ""
                value = ""
            }
        }
    }
}
