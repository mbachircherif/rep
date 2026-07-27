//
//  ProductOptionView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 17/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var optionToUpdate: ProductOption?

    var option: ProductOption

    private var valuesPreview: [ProductOptionValue] {
        Array(option.values.prefix(5))
    }

    var body: some View {
        List {
            Section {
                Text(option.name)
            } header: {
                Text("Détail")
            }

            Section {
                NavigationLink {
                    ProductOptionValueList(option: option)
                } label: {
                    LabeledContent("Valeurs") {
                        Text(option.values.count, format: .number)
                    }
                }
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
        .sheet(item: $optionToUpdate) { option in
            ProductOptionUpdateForm(option: option)
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    optionToUpdate = option
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .navigationTitle(option.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func delete() {
        do {
            if let product = option.product {

                let optionPosition = option.position
                let productOptionValuesCount = option.values.count

                /// If there're not values in the deleted option, no need go delete variants
                if productOptionValuesCount > 0 {
                    // TODO: Maybe use FetchDescriptor ? Options is small in general
                    let nonEmptyOptions = product.options.filter {
                        $0.persistentModelID != option.id && !$0.values.isEmpty
                    }

                    /// If there's only one value left over the options, we delete the resting variants
                    /// ex:
                    /// - O1 [1, 2] <- Only option left
                    /// - O2 []
                    /// - O3 []
                    if nonEmptyOptions.count == 0 {
                        /// Delete all resting variants
                        try fetchProductVariants(for: product).forEach {
                            modelContext.delete($0)
                        }
                    } else {
                        /// The deleted option still has values, e.g. `O1 [1, 2]`.
                        ///
                        /// We must remove every variant attribute tied to `O1` and then **collapse**
                        /// the variants that have become duplicates.
                        ///
                        /// The algorithm walks every variant. For each one, it builds a *path* from the
                        /// variant's attributes in position order, **excluding** the attribute that belongs
                        /// to the option being deleted. That path uniquely identifies the variant once `O1`
                        /// is gone. We track the paths we've already seen:
                        /// 1. If the path has **not** been visited yet, we keep the variant and only delete
                        ///    its attribute that belongs to `O1`.
                        /// 2. If the path has **already** been visited, the variant is now a duplicate, so we
                        ///    delete the whole variant.
                        ///
                        /// Example — deleting `O1 [1, 2]`, keeping `O2 [A, B]`:
                        ///
                        /// | Variant  | Path (excl. `O1`) | Visited? | Outcome                    |
                        /// | -------- | ----------------- | -------- | -------------------------- |
                        /// | V1 [1,A] | [A]               | no       | keep, delete attribute `1` |
                        /// | V2 [1,B] | [B]               | no       | keep, delete attribute `1` |
                        /// | V3 [2,A] | [A]               | yes      | delete whole variant       |
                        /// | V4 [2,B] | [B]               | yes      | delete whole variant       |

                        var visitedAttributes: Set<[PersistentIdentifier]> = []

                        for variant in try fetchProductVariants(for: product){
                            let variantAttributes: [ProductVariantAttribute] = try fetchProductVariantAttributes(for: variant, position: optionPosition)

                            // Loop over for variant attribute that not belong to the deleted option.
                            var path: [PersistentIdentifier] = []

                            for attribute in variantAttributes {
                                if attribute.optionValue?.option?.id == option.id {
                                    modelContext.delete(attribute)
                                } else {
                                    if let optionValueID = attribute.optionValue?.id {
                                        path.append(optionValueID)
                                    }
                                }
                            }

                            if visitedAttributes.contains(path) {
                                modelContext.delete(variant)
                            }

                            visitedAttributes.insert(path)
                        }
                    }
                }

                modelContext.delete(option)

                try modelContext.save()
            }

            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func fetchProductVariants(for product: Product) throws -> [ProductVariant] {
        let productID = product.id

        var productVariantsFetchDescriptor = FetchDescriptor<ProductVariant>()

        productVariantsFetchDescriptor.predicate = #Predicate { $0.product?.persistentModelID == productID }

        return try modelContext.fetch(productVariantsFetchDescriptor)
    }

    private func fetchProductVariantAttributes(for variant: ProductVariant, position: Int) throws -> [ProductVariantAttribute] {
        let variantID = variant.id

        var productVariantAttributesFetchDescriptor = FetchDescriptor<ProductVariantAttribute>()

        productVariantAttributesFetchDescriptor.predicate = #Predicate { $0.variant?.persistentModelID == variantID }
        productVariantAttributesFetchDescriptor.sortBy = [SortDescriptor(\.position)]

        return try modelContext.fetch(productVariantAttributesFetchDescriptor)
    }
}
