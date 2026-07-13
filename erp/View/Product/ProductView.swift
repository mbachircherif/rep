//
//  ProductView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftUI

struct ProductView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(SwiftDataManager.self)
    private var db

    @State
    private var productVariantCreateFormPresented: Bool = false

    var product: Product

    var body: some View {
        List {

            Section {
                LabeledContent("Nom", value: product.name)
            } header: {
                Text("Détail")
            }

            Section {
                ForEach(product.variants) { variant in
                    NavigationLink {
                        ProductVariantView(variant: variant)
                    } label: {
                        HStack {
                            Text(variant.sku)

                            Spacer()

                            Text(variant.price.amount, format: .currency(code: variant.price.currency.rawValue))
                        }
                    }
                }

                Button("Ajouter un variant") {
                    productVariantCreateFormPresented = true
                }
            } header: {
                Text("Variants")
            }
        }
        .sheet(isPresented: $productVariantCreateFormPresented) {
            NavigationStack {
                ProductVariantCreateFormView(product: product)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(role: .cancel) {
                                productVariantCreateFormPresented = false
                            }
                        }
                    }
            }
        }
    }
}
