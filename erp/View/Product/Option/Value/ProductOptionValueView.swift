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
                // Remove the value from option values
                option.values.removeAll { $0.id == value.id }

                // Remove the option value in all variants
                for (index, variant) in product.variants.enumerated() {
                    // Remove the corresponding varaint attribute
                    variant.attributes.removeAll { $0.optionValue?.name == value.name }

                    // If it was the last attribute, delete the variant
                    if variant.attributes.isEmpty {
                        product.variants.remove(at: index)
                    }
                }
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
