//
//  OrderUpdateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftData
import SwiftUI

struct OrderUpdateFormView: View {

    @Environment(\.modelContext)
    private var modelContext

    let id: PersistentIdentifier

    var body: some View {
        UpdateModelView(type: Order.self, id: id) { order in
            @Bindable var order = order

            Form {
                Section {
                    Picker(selection: $order.status) {
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
                            switch order.status {
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

                ForEach(order.lines) { line in
                    HStack {
                        Text(line.variant.sku)
                            .font(.system(size: 13.0, design: .default))

                        Text(line.quantity, format: .number)
                    }
                }

                Section {
                    Text("\(order.customer.firstName) \(order.customer.lastName)")
                }

                Button("Update") {
                    try? modelContext.save()
                }
            }
        }
    }
}
