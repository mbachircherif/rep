//
//  ProductOptionValueUpdateForm.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionValueUpdateForm: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

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
                        cancel()
                    }
                    .disabled(value.name == name)
                }
            }
            .navigationTitle("Édition")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func update() {
        // Check form
        try? modelContext.save()
        dismiss()
    }

    private func cancel() {
        dismiss()
    }
}
