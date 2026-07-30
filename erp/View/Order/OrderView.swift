//
//  OrderView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftUI

struct OrderView: View {

    @State
    private var isOrderUpdateFormPresented: Bool = false

    var order: Order

    var body: some View {
        List {
            Section {
                LabeledContent("Number", value: order.number.uuidString)

                LabeledContent("Statut") {
                    switch order.status {
                    case .waiting:
                        HStack {
                            Circle()
                                .fill(.orange)
                                .fixedSize()

                            Text("En attente")
                        }
                    case .paid:
                        HStack {
                            Circle()
                                .fill(.green)
                                .fixedSize()

                            Text("Payé")
                        }
                    case .canceled:
                        HStack {
                            Circle()
                                .fill(.red)
                                .fixedSize()

                            Text("Annulée")
                        }
                    }
                }
            } header: {
                Text("Détails")
            }

            Section {
                Text(order.customer.fullName)
            }

            Section {
                ForEach(order.variants) { variant in
                    HStack(spacing: 16.0) {
                        ContainerRelativeShape()
                            .fill(.quinary)
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: 50.0)

                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(variant.name)
                                .foregroundStyle(.primary)
                                .font(.default)
                                .lineLimit(1)

                            Text(variant.sku)
                                .foregroundStyle(.secondary)
                                .font(.footnote)
                                .lineLimit(1)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 8.0) {
                            Text("\(variant.subtotal, format: .currency(code: order.warehouse.currency.rawValue)) (HT)")
                                .lineLimit(1)

                            Text("\(variant.quantity.amount, format: .number) \(variant.quantity.unit.symbol)")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                }
            } header: {
                Text("Articles")
            }

            Section {
                // Subtotal
                LabeledContent("Sous-total (HT)", value: order.subtotal, format: .currency(code: order.warehouse.currency.rawValue))

                // Taxes
                ForEach(Array(order.taxes), id: \.key) { tax, amount in
                    LabeledContent("TVA (\(tax.rate, format: .percent))", value: amount, format: .currency(code: order.warehouse.currency.rawValue))
                }

                // Total
                LabeledContent("Total", value: order.total, format: .currency(code: order.warehouse.currency.rawValue))
                    .fontWeight(.medium)
            }
        }
        .listRowSpacing(16.0)
        .sheet(isPresented: $isOrderUpdateFormPresented) {
            NavigationStack {
                OrderUpdateForm(order: order)
            }
        }
        .navigationTitle("Numéro de commande")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isOrderUpdateFormPresented = true
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}
