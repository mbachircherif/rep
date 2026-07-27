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
    private var name: Field<String>

    private let option: ProductOption

    init(option: ProductOption) {
        self._name = State(wrappedValue: Field(value: option.name))

        self.option = option
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Requis", text: $name.value)
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
            if let product = option.product {
                // Options are genrally few (1 to 3 average).
                // We can interact with product.options

                guard product.options.contains(where: { $0.name == name.value }) == false else {
                    throw FieldError(field: "name", reason: "Valeur déjà ajoutée")
                }

                let productID: PersistentIdentifier = product.id

                var lastProductOptionFetchDescriptor = FetchDescriptor<ProductOption>()

                lastProductOptionFetchDescriptor.predicate = #Predicate { $0.product?.persistentModelID == productID }
                lastProductOptionFetchDescriptor.sortBy = [SortDescriptor(\.position, order: .reverse)]
                lastProductOptionFetchDescriptor.fetchLimit = 1

                let lastProductVariantPosition: Int = try modelContext.fetch(lastProductOptionFetchDescriptor).first?.position ?? 0

                option.name = name.value
                option.position = lastProductVariantPosition + 1

                option.product?.options.append(option)
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
