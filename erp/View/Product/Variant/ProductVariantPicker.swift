//
//  ProductVariantPicker.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 29/07/2026.
//

import SwiftUI

struct ProductVariantPicker<Label>: View where Label : View {

    let variants: [ProductVariant]

    let onPick: ((ProductVariant) -> Void)

    @ViewBuilder
    let label: (ProductVariant) -> Label

    private var productGroupedVariants: [Product : [ProductVariant]] {
        var result: [Product : [ProductVariant]] = [:]

        for variant in variants {
            if let product = variant.product {
                if result[product] == nil {
                    result[product] = [variant]
                } else {
                    result[product]?.append(variant)
                }
            }
        }

        return result
    }

    var body: some View {
        List {

            // TODO: Cache in a @Observable model.
            let data = productGroupedVariants

            ForEach(data.keys.sorted { $0.createdAt < $1.createdAt }) { product in
                Section(product.name) {
                    ForEach((data[product] ?? [])) { variant in
                        Button {
                            onPick(variant)
                        } label: {
                            label(variant)
                        }
                        .disabled(variant.stock.amount.isZero)
                    }
                }
            }
        }
    }
}
