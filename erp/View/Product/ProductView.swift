//
//  ProductView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData
import SwiftUI

struct ProductView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(SwiftDataManager.self)
    private var db

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var productVariantCreateFormPresented: Bool = false

    @State
    private var productOptionToCreate: ProductOption?

    var product: Product

    private var positionSortedVariant: [ProductVariant] {
        product.variants.sorted { $0.position < $1.position }
    }

    var body: some View {
        List {

            Section {
                LabeledContent("Nom", value: product.name)
            } header: {
                Text("Détail")
            }

            Section {
                NavigationLink {
                    ProductOptionList(product: product)
                } label: {
                    LabeledContent("Options", value: product.options.count, format: .number)
                }
            }

            Section {
                ForEach(positionSortedVariant) { variant in
                    NavigationLink {
                        ProductVariantView(variant: variant)
                    } label: {
                        HStack {
                            let sortedAttributes = variant.attributes.sorted(by: { $0.position < $1.position })

                            Text(sortedAttributes.map(\.optionValue.name).joined(separator: "/"))

                            Spacer()

                            // TODO: Provide a default currency based on Locale
                            Text(variant.sellingPrice, format: .currency(code: product.warehouse?.currency.rawValue ?? "EUR"))
                        }
                    }
                }
            } header: {
                Text("Variants")
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(role: .destructive) {
                    product.warehouse?.products.removeAll { $0.name == product.name }
                    try? modelContext.save()
                }
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
        .onAppear {
            for variant in positionSortedVariant {
                print(variant.position)
            }
        }
    }
}
