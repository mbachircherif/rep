//
//  ProductOptionValueCreateForm.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

import Algorithms
import SwiftData
import SwiftUI

struct ProductOptionValueCreateForm: View {

    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var name: Field<String>

    private let value: ProductOptionValue

    init(value: ProductOptionValue) {
        self._name = State(wrappedValue: Field(value: value.name, state: .idle))

        self.value = value
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Requis", text: $name.value)
                        .onChange(of: name.value) {
                            if name.state.isError == true { name.state = .idle }
                        }
                } header: {
                    Text("Nom")
                } footer: {
                    if case let .error(reason) = name.state {
                        Label(reason, systemImage: "exclamationmark.circle.fill")
                            .foregroundStyle(.red)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) {
                        cancel()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        create()
                    }
                }
            }
            .navigationTitle("Nouveau")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func create() {
        do {
            if let option = value.option, let product = option.product {

                guard option.values.contains(where: { $0.name == name.value }) == false else {
                    throw FieldError(field: "name", reason: "Valeur déjà ajoutée")
                }
                
                /// Update value's fields
                value.name = name.value
                
                /// Add value to option values
                option.values.append(value)

                let nonEmptyOptions = product.options.filter { !$0.values.isEmpty }

                if nonEmptyOptions.count > 1 && option.values.count == 1 {
                    ///
                    /// Perform additive attribute operation on existing variant only if
                    /// the sum of non empty options is superior to 1 and the new option value is the only one too belong to its option.
                    /// ex:
                    /// Size[S], Color[], Shape[]
                    /// Thus, we keep the exiting variant without deleting and creating a new one.
                    ///

                    for variant in product.variants {
                        let attributePosition = variant.attributes.count
                        let attribute = ProductVariantAttribute(variant: variant, optionValue: value, position: attributePosition)

                        variant.attributes.append(attribute)
                    }
                } else {
                    ///
                    /// Perform cartesian product for the rest of the cases.
                    /// ex:
                    /// - Size[S] || Size[S, **M**] || Size[S], Color[Red, **Green**] || Size[S, **M**], Color[Red, Green]
                    /// The option value in bold represent the a new option value being inserted.
                    ///
                    /// Given:
                    /// - Size[S, **M**], Color[Red, Green]
                    ///
                    /// Result:
                    /// - [S, Red]
                    /// - [S, Green]
                    /// - [M, Red]
                    /// - [M- Green]
                    ///

                    /// Tree options is reversed.
                    let productOptions        = product.options.sorted { $0.position > $1.position }
                    let productOptionsCount   = productOptions.count
                    let productOptionPosition = (productOptionsCount - 1) - option.position

                    let newOptionValues = [value]
                    
                    func createVariantCombinations(values: [ProductOptionValue], depth: Int) {
                        // No more node to path. We reach a leaf of the option values tree.
                        if depth == productOptionsCount {
                            let newProductVariant = ProductVariant(product: product, position: product.variants.count)

                            let productOptionValueCount = values.count

                            /// We fill the variant attributes in the reverse order as they stack since options are in the reversed the tree..
                            for index in values.indices {
                                let productOptionValue = values[index]
                                let productVariantAttribute = ProductVariantAttribute(variant: newProductVariant, optionValue: productOptionValue, position: productOptionValueCount - (index + 1))

                                newProductVariant.attributes.append(productVariantAttribute)
                            }

                            product.variants.append(newProductVariant)
                        } else {
                            /// The mental model is to picture the options as floors of a building, one option per floor:
                            /// - Floor 1: Size      [S, M]
                            /// - Floor 2: Color    [Red, Green]
                            /// - Floor 3: Shape  [Square, Circle]
                            ///
                            /// Each recursive call descends one floor and picks the values of that floor's option, branching once per value.
                            /// Reaching the ground floor (`depth == productOptionsCount`) means a full combination has been assembled, so a variant is created.
                            ///
                            /// The floor matching the new value's option is the exception: instead of iterating over its existing values,
                            /// we substitute the single new value, since only combinations that include it need to be generated.
                            ///
                            /// ex:
                            /// Inserting Size[L] with Size on floor 1. When `depth` reaches floor 1, we branch over [L] instead of [S, M].

                            let productOptionsValue = if depth == productOptionPosition {
                                newOptionValues
                            } else {
                                productOptions[depth].values.sorted { $0.position < $1.position}
                            }

                            /// Sometimes, option values can be empty because the user can create all its options before adding some values in them.
                            if productOptionsValue.isEmpty {
                                createVariantCombinations(values: values, depth: depth + 1)
                            } else {
                                for productOptionValue in productOptionsValue {
                                    createVariantCombinations(values: values + [productOptionValue], depth: depth + 1)
                                }
                            }
                        }
                    }

                    createVariantCombinations(values: [], depth: 0)
                }
            }

            if modelContext.hasChanges {
                try modelContext.save()
            }

            dismiss()
        } catch let fieldError as FieldError {
            switch fieldError.field {
            case "name":
                name.state = .error(reason: fieldError.reason)
            default:
                break
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func cancel() {
        dismiss()
    }
}
