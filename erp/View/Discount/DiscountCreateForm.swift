//
//  DiscountCreateForm.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 31/07/2026.
//

import SwiftUI

struct DiscountCreateForm: View {

    @Environment(\.dismiss)
    private var dismiss

    struct CreateForm {

        // TODO: Use Field
        var name: String = ""

        var type: ValueType = .percentage

        var value: Decimal = 0

        var isValid: Bool {
            !name.isEmpty && !value.isZero
        }
    }

    @State
    private var form = CreateForm()

    var onCreate: (CreateForm) -> Void

    var body: some View {
        Form {
            Section {
                TextField("Nom", text: $form.name)
            }

            Section {
                Picker("Type", selection: $form.type) {
                    Text("Fixe")
                        .tag(ValueType.fixed)

                    Text("Pourcentage")
                        .tag(ValueType.percentage)
                }
            }

            Section {
                switch form.type {
                case .fixed:
                    TextField("Montant", value: $form.value, format: .number)
                case .percentage:
                    TextField("Taux", value: $form.value, format: .percent)
                }
            }
        }
        .navigationTitle("Réduction")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    cancel()
                }
                .disabled(!form.isValid)
            }

            ToolbarItem(placement: .confirmationAction) {
                Button(role: .confirm) {
                    create()
                }
            }
        }
    }

    private func cancel() {
        dismiss()
    }

    private func create() {
        onCreate(form)
    }
}
