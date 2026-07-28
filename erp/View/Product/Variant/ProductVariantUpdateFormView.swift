//
//  ProductVariantUpdateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftData
import SwiftUI

struct ProductVariantUpdateFormView: View {

    private enum FieldKey {

        case sku, costPrice, sellingPrice, tax, stock
    }

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var sku: Field<FieldKey, String>

    @State
    private var costPrice: Field<FieldKey, Decimal>

    @State
    private var sellingPrice: Field<FieldKey, Decimal>

    @State
    private var tax: Field<FieldKey, Tax>

    @State
    private var stock: Field<FieldKey, Stock>

    var variant: ProductVariant

    init(variant: ProductVariant) {
        self._sku          = State(wrappedValue: Field(key: .sku, value: variant.sku))
        self._costPrice    = State(wrappedValue: Field(key: .costPrice, value: variant.costPrice))
        self._sellingPrice = State(wrappedValue: Field(key: .sellingPrice, value: variant.sellingPrice))
        self._tax          = State(wrappedValue: Field(key: .tax, value: variant.tax))
        self._stock        = State(wrappedValue: Field(key: .stock, value: variant.stock))

        self.variant = variant
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("SKU", text: $sku.value)
                }
                
                Section {
                    LabeledContent("Prix de revient") {
                        // TODO: Provide a default currency based on Locale
                        TextField("", value: $costPrice.value, format: .currency(code: variant.product?.warehouse?.currency.rawValue ?? "EUR"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Prix de vente") {
                        // TODO: Provide a default currency based on Locale
                        TextField("", value: $sellingPrice.value, format: .currency(code: variant.product?.warehouse?.currency.rawValue ?? "EUR"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                } header: {
                    Text("Prix")
                }
                
                Section {
                    LabeledContent("Taux") {
                        TextField("", value: $tax.value.rate, format: .percent)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                } header: {
                    Text("TVA")
                }
                
                Section {
                    TextField("", value: $stock.value.amount, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("Unité", selection: $stock.value.unit) {
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
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) {
                        cancel()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        confirm()
                    }
                }
            }
        }
    }

    private func cancel() {
        dismiss()
    }

    private func confirm() {
        do {
            variant.sku = sku.value
            variant.costPrice = costPrice.value
            variant.sellingPrice = sellingPrice.value
            variant.tax = tax.value
            variant.stock = stock.value

            // TODO: To delete when after validation form implementation.
            if modelContext.hasChanges {
                try modelContext.save()
            }

            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
