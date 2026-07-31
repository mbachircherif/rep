//
//  OrderProductVariantPicker.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 29/07/2026.
//

import SwiftData
import SwiftUI

// TODO: Naming ?
struct OrderProductVariantPicker: View {

    let warehouse: Warehouse

    var form: OrderCreateForm

    @Binding
    var selectedVariants: [ProductVariant]

    private var productVariants: [ProductVariant] {
        warehouse.products
            .flatMap(\.variants)
            .sorted { $0.position < $1.position }
    }

    var body: some View {
        ProductVariantPicker(variants: productVariants) { variant in
            if let variantIndex = selectedVariants.firstIndex(where: { $0.id == variant.id }) {
                selectedVariants.remove(at: variantIndex)
                form.items.remove(at: variantIndex)
            } else {
                selectedVariants.append(variant)
                form.items.append(OrderFormItem(from: variant, form: form))
            }
        } label: { variant in
            HStack {
                if selectedVariants.contains(where: { $0.id == variant.id }) {
                    Image(systemName: "checkmark.circle.fill")
                } else {
                    Image(systemName: "circle")
                }

                let sortedAttributes = variant.attributes.sorted { $0.position < $1.position }

                // Attributes
                Text(sortedAttributes.compactMap(\.optionValue?.name).joined(separator: "/"))

                Spacer()

                // SKU
                Text(variant.sku)
                // Price
                Text(variant.sellingPrice, format: .currency(code: variant.product?.warehouse?.currency.rawValue ?? "EUR"))
            }
        }
    }
}
