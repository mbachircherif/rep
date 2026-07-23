//
//  ProductOptionValueCreateForm.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionValueCreateForm: View {

    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var name: String

    private let value: ProductOptionValue

    init(value: ProductOptionValue) {
        self._name = State(wrappedValue: value.name)

        self.value = value
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
        // Check form
        value.name = name
        value.option?.values.append(value)
        try? modelContext.save()
        dismiss()
    }

    private func cancel() {
        dismiss()
    }
}
