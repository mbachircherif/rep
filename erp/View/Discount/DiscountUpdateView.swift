//
//  DiscountUpdateView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 02/08/2026.
//

import SwiftUI

struct DiscountUpdateView: View {

    @Environment(\.dismiss)
    private var dismiss

    struct UpdateForm {

        // TODO: Use Field
        var name: String = ""

        var type: ValueType = .percentage

        var value: Decimal = 0

        var isValid: Bool {
            !name.isEmpty && !value.isZero
        }
    }

    @State
    private var form = UpdateForm()

    var onUpdate: (UpdateForm) -> Void

    init<T>(discount: T, onUpdate: @escaping (UpdateForm) -> Void) where T : Discount {
        self._form = State(wrappedValue: UpdateForm(name: discount.name, type: discount.type, value: discount.value))
        self.onUpdate = onUpdate
    }

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

            Section {
                Button {
                    onUpdate(form)
                } label: {
                    Text("Sauvegarder")
                }
                .buttonStyle(PrimaryButtonStyle())
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
        }
        .navigationTitle("Réduction")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}
