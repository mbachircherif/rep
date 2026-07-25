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
    private var stock: Stock = Stock(amount: 0, unit: .quantity)

    var product: Product

    var body: some View {
        Form {
            
            Section {
                TextField("SKU", text: $sku)
            }

            Section {
                LabeledContent("Prix de revient") {
                    // TODO: Provide a default currency based on Locale
                    TextField("", value: $costPrice, format: .currency(code: product.warehouse?.currency.rawValue ?? "EUR"))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }

                LabeledContent("Prix de vente") {
                    // TODO: Provide a default currency based on Locale
                    TextField("", value: $sellingPrice, format: .currency(code: product.warehouse?.currency.rawValue ?? "EUR"))
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
    }
}
