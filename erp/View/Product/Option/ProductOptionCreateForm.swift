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
        }
    }

    private func create() {
        // Check form
        option.name = name
        option.product?.options.append(option)
        try? modelContext.save()
        dismiss()
    }

    private func cancel() {
        dismiss()
    }
}
