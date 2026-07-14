//
//  OrderVariantView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import SwiftUI

struct OrderVariantView: View {

    @Environment(\.delete)
    private var delete

    @Environment(\.dismiss)
    private var dismiss

    var variant: OrderVariant

    var body: some View {
        @Bindable var variant = variant

        Form {
            Section {
                LabeledContent("SKU", value: variant.sku)
            } header: {
                Text("Détails")
            }

            Section {
                LabeledContent("Quantité") {
                    TextField("Requis", value: $variant.stock.amount, format: .number)
                        .keyboardType(.numberPad)
                }
            }

            Section {
                LabeledContent("Total", value: variant.total, format: .currency(code: variant.order.warehouse.currency.rawValue))
            }

            Button("Supprimer", role: .destructive) {
                delete()
                dismiss()
            }
        }
    }
}
