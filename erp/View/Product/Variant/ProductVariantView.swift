//
//  ProductVariantView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftUI

struct ProductVariantView: View {

    @State
    private var deletedAttribute: ProductVariantAttribute?

    @State
    private var attributeCreateFormPresented: Bool = false

    var variant: ProductVariant

    var body: some View {
        List {

            Section {
                LabeledContent("SKU", value: variant.sku)
            } header: {
                Text("Détail")
            }

            Section {
                ForEach(variant.attributes.enumerated(), id: \.element) { index, attribute in
                    HStack(spacing: 24.0) {
                        Text(attribute.key)

                        Spacer()

                        switch attribute.kind {
                        case .color:
                            if let color = Color(hex: attribute.value) {
                                Circle()
                                    .fill(color)
                                    .frame(width: 20.0, height: 20.0)
                            }
                        case .custom:
                            Text(attribute.value)
                        }

                        Button {
                            variant.attributes.remove(at: index)
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }

                Button("Ajouter une caractéristique") {
                    attributeCreateFormPresented = true
                }
            } header: {
                Text("Caractéristiques")
            }
        }
        .sheet(isPresented: $attributeCreateFormPresented) {
            NavigationStack {
                ProductVariantAttributeCreateFormView(variant: variant)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(role: .cancel) {
                                attributeCreateFormPresented = false
                            }
                        }
                    }
            }
        }
    }
}
