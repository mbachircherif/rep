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

    var optionsPreview: [ProductOption] {
        Array(product.options.prefix(5))
    }

    var body: some View {
        List {

            Section {
                LabeledContent("Nom", value: product.name)
            } header: {
                Text("Détail")
            }

            Section {
                ForEach(optionsPreview) { option in
                    Text(option.name)
                }
            } header: {
                HStack {
                    Text("Options")

                    Spacer()

                    NavigationLink("Voir tout") {
                        ProductOptionList(product: product)
                    }
                }
            }

            Section {
                ForEach(product.variants) { variant in
                    NavigationLink {
                        ProductVariantView(variant: variant)
                    } label: {
                        HStack {
                            Text(variant.sku)

                            Spacer()

                            Text(variant.sellingPrice, format: .currency(code: product.warehouse.currency.rawValue))
                        }
                    }
                }
            } header: {
                Text("Variants")
            }
        }
        .onAppear {
            print("MAIN ACTOR MODEL CONTEXT: \(Unmanaged.passUnretained(modelContext).toOpaque())")
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
    }
}
