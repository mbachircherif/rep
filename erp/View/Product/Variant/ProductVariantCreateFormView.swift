//
//  ProductVariantCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftUI

struct ProductVariantCreateFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var sku: String = ""

    @State
    private var costPrice: Decimal = 0.0

    @State
    private var sellingPrice: Decimal = 0.0

    @State
    private var tax: Tax = Tax(rate: 0.0, behavior: .inclusive)

    @State
    private var stock: Stock = Stock()

    var product: Product

    var body: some View {
        Form {
            
            Section {
                TextField("SKU", text: $sku)
            }

            Section {
                LabeledContent("Prix de revient") {
                    TextField("", value: $costPrice, format: .currency(code: product.warehouse.currency.rawValue))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }

                LabeledContent("Prix de vente") {
                    TextField("", value: $sellingPrice, format: .currency(code: product.warehouse.currency.rawValue))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
            } header: {
                Text("Prix")
            }

            Section {
                LabeledContent("Taux") {
                    TextField("", value: $tax.rate, format: .percent)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
            } header: {
                Text("TVA")
            }

            Section {
                TextField("", value: $stock.amount, format: .number)
                    .keyboardType(.decimalPad)

                Picker("Unité", selection: $stock.unit) {
                    Group {
                        ForEach(Unit.allCases, id: \.self) { unit in
                            switch unit {
                            case .quantity:
                                Text("Quantité")
                            }
                        }
                    }
                }
            } header: {
                Text("Stock")
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Ajouter") {
                    product.variants.append(ProductVariant(sku: sku, product: product, attributes: [], costPrice: costPrice, sellingPrice: sellingPrice, tax: tax, stock: stock))
                    dismiss()
                }
                .buttonStyle(.glassProminent)
            }
        }
    }
}
