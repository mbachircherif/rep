//
//  ProductOptionValueView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionValueView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var valueToUpdate: ProductOptionValue?

    var value: ProductOptionValue

    var body: some View {
        List {
            Section {
                Text(value.name)
            } header: {
                Text("Détail")
            }

            Button {
                delete()
            } label: {
                Text("Supprimer")
                    .font(.system(size: 18.0, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.red)
        }
        .sheet(item: $valueToUpdate) { value in
            ProductOptionValueUpdateForm(value: value)
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    valueToUpdate = value
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .navigationTitle(value.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func delete() {
        do {
            let option  = value.option
            let product = option?.product

            if let option, let product {

                let nonEmptyOptions = product.options.filter { !$0.values.isEmpty }

                if nonEmptyOptions.count > 1 && option.values.count == 1 {
                    /// We just removing leafs, so no variants deletion.
                    for variant in product.variants {

                        let variantID: PersistentIdentifier = variant.id
                        let optionPosition: Int = option.position

                        var lastProductVariantAttributeFetchDescriptor = FetchDescriptor<ProductVariantAttribute>()

                        lastProductVariantAttributeFetchDescriptor.predicate = #Predicate {
                            $0.variant?.persistentModelID == variantID &&
                            $0.position == optionPosition
                        }

                        lastProductVariantAttributeFetchDescriptor.fetchLimit = 1

                        let lastProductVariantAttribute: ProductVariantAttribute? = try modelContext.fetch(lastProductVariantAttributeFetchDescriptor).first

                        if let lastProductVariantAttribute {
                            modelContext.delete(lastProductVariantAttribute)
                        }
                    }
                } else {
                    for attribute in value.variantAttributes {
                        if let variant = attribute.variant {
                            modelContext.delete(variant)
                        }
                    }
                }

                modelContext.delete(value)
            }

            if modelContext.hasChanges {
                try modelContext.save()
            }

            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
