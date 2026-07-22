//
//  ProductOptionUpdateForm.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 18/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionUpdateForm: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var name: String

    private let option: ProductOption

    init(option: ProductOption) {
        self._name = State(wrappedValue: option.name)

        self.option  = option
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
                    .disabled(option.name == name)
                }
            }
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
