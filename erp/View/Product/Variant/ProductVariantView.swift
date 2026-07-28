//
//  ProductVariantView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftUI

struct ProductVariantView: View {

    @State
    private var variantToUpdate: ProductVariant?

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
                    HStack(spacing: 16.0) {
                        Text(attribute.optionValue?.option?.name ?? "-")

                        Spacer()

                        Text(attribute.optionValue?.name ?? "-")
                    }
                }
            } header: {
                Text("Caractéristiques")
            } footer: {
                Text("Les caractéristiques sont générées automatiquement en fonction des options de base de ce produit.")
            }

            Section {
                LabeledContent("Prix de revient") {
                    // TODO: Provide a default currency based on Locale
                    Text(variant.costPrice, format: .currency(code: variant.product?.warehouse?.currency.rawValue ?? "EUR"))
                }

                LabeledContent("Prix de vente") {
                    // TODO: Provide a default currency based on Locale
                    Text(variant.sellingPrice, format: .currency(code: variant.product?.warehouse?.currency.rawValue ?? "EUR"))
                }
            } header: {
                Text("Prix")
            }

            Section {
                LabeledContent("Taux") {
                    Text(variant.tax.rate, format: .percent)
                }
            } header: {
                Text("TVA")
            }

            Section {
                LabeledContent {
                    Text(variant.stock.unit.symbol)
                } label: {
                    Text(variant.stock.amount, format: .number)
                }
            } header: {
                Text("Stock")
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    variantToUpdate = variant
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .sheet(item: $variantToUpdate) { variant in
            ProductVariantUpdateFormView(variant: variant)
        }
    }
}
