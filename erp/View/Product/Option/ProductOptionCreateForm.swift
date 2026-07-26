//
//  ProductOptionCreateForm.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 18/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionCreateForm: View {

    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var name: String

    private let option: ProductOption

    init(option: ProductOption) {
        self._name = State(wrappedValue: option.name)

        self.option = option
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Requis", text: $name)
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
            if let product = option.product {
                // Check form

                let productID: PersistentIdentifier = product.id

                var lastProductOptionFetchDescriptor = FetchDescriptor<ProductOption>()

                lastProductOptionFetchDescriptor.predicate = #Predicate { $0.product?.persistentModelID == productID }
                lastProductOptionFetchDescriptor.sortBy = [SortDescriptor(\.position, order: .reverse)]
                lastProductOptionFetchDescriptor.fetchLimit = 1

                let lastProductVariantPosition: Int = try modelContext.fetch(lastProductOptionFetchDescriptor).first?.position ?? 0

                option.name = name
                option.position = lastProductVariantPosition + 1

                option.product?.options.append(option)
                try modelContext.save()
            }

            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func cancel() {
        dismiss()
    }
}
