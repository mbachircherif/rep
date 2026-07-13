//
//  ProductVariantCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftData
import SwiftUI

struct ProductVariantCreateFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var sku: String = ""

    @State
    private var price: Price = Price(amount: 0.0, currency: .eur)

    @State
    private var stock: Stock = Stock()

    var product: Product

    var body: some View {
        Form {
            
            Section {
                TextField("SKU", text: $sku)
            }

            Section {
                TextField("", value: $price.amount, format: .currency(code: price.currency.rawValue))

                Picker("Devise", selection: $price.currency) {
                    Group {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.rawValue)
                                .tag(currency)
                        }
                    }
                }
            } header: {
                Text("Prix")
            }

            Section {
                TextField("", value: $stock.amount, format: .number)

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
                    product.variants.append(ProductVariant(sku: sku, product: product, attributes: [], price: price, stock: stock))
                    dismiss()
                }
            }
        }
    }
}
