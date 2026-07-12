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
    private var showAttributeMaker: ProductVariant?

    var product: Product

    var body: some View {
        List {
            Text(product.id.debugDescription)

            Section {
                ForEach(product.variants) { variant in
                    DisclosureGroup {
                        ForEach(variant.attributes) { attribute in
                            Text(attribute.id.debugDescription)
                        }

                        Button("Add Attribute") {
                            showAttributeMaker = variant
                        }
                    } label: {
                        Text("Variant \(variant.id.debugDescription)")
                    }
                }
            }
        }
        .sheet(item: $showAttributeMaker) { variant in
            NavigationStack {
                AttributeFormView(variant: variant)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") {
                    product.variants.append(ProductVariant(sku: "SKU-\(product.variants.count)", product: product, attributes: [], price: Price(amount: 100.0, currency: .eur), stock: Stock(amount: 100, unit: .quantity)))
                }
            }
        }
    }
}
