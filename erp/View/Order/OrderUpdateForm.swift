//
//  OrderUpdateForm.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftData
import SwiftUI

struct OrderUpdateForm: View {

    struct UpdateForm: Equatable {

        var status: Order.Status
    }

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var form: UpdateForm

    let order: Order

    init(order: Order) {
        self._form = State(wrappedValue: UpdateForm(status: order.status))
        self.order = order
    }

    var body: some View {
        Form {
            Section {
                Picker(selection: $form.status) {
                    ForEach(Order.Status.allCases, id: \.self) { status in
                        Group {
                            switch status {
                            case .waiting:
                                Text("En attente")
                            case .paid:
                                Text("Payée")
                            case .canceled:
                                Text("Annulé")
                            }
                        }
                        .tag(status)
                    }
                } label: {
                    HStack {
                        switch form.status {
                        case .waiting:
                            Circle()
                                .fill(.yellow)
                                .fixedSize()

                            Text("En attente")
                        case .paid:
                            Circle()
                                .fill(.green)
                                .fixedSize()

                            Text("Payé")
                        case .canceled:
                            Circle()
                                .fill(.red)
                                .fixedSize()

                            Text("Annulé")
                        }
                    }
                }
            }
        }
        .navigationTitle(order.number.uuidString)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(role: .confirm) {
                    update()
                }
            }

            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    cancel()
                }
            }
        }
    }

    private func cancel() {
        dismiss()
    }

    private func update() {
        do {
            order.status = form.status

            try modelContext.save()

            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
