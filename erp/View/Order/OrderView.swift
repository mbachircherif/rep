//
//  OrderView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftUI

struct OrderView: View {

    var order: Order

    var body: some View {
        List {

            Section {
                LabeledContent("Number", value: order.number.uuidString)

                LabeledContent("Status") {
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

                            Text("Annulés")
                        }
                    }
                }
            } header: {
                Text("Détails")
            }

            Section {
                if order.customer.firstName.isEmpty && order.customer.lastName.isEmpty {
                    Text("Aucun client associé.")
                } else {
                    Text("\(order.customer.firstName) \(order.customer.firstName)")
                }
            } header: {
                Text("Client")
            }

            Section {
                ForEach(order.variants) { variant in
                    if let productVariant = variant.reference {
                        NavigationLink {
                            ProductVariantView(variant: productVariant)
                        } label: {
                            HStack {
                                Text(variant.sku)

                                Spacer()

                                Text("\(variant.stock.amount, format: .number) \(variant.stock.unit.symbol)")

                                Spacer()

                                Text(variant.sellingPrice, format: .currency(code: order.warehouse.currency.rawValue))
                            }
                        }
                    } else {
                        HStack {
                            Text(variant.sku)

                            Spacer()

                            Text("\(variant.stock.amount, format: .number) \(variant.stock.unit.symbol)")

                            Spacer()

                            Text(variant.sellingPrice, format: .currency(code: order.warehouse.currency.rawValue))
                        }
                    }
                }
            } header: {
                Text("Articles")
            }

            Section {
                LabeledContent("Sous-total", value: order.subtotal, format: .currency(code: order.warehouse.currency.rawValue))

                LabeledContent("Total", value: order.total, format: .currency(code: order.warehouse.currency.rawValue))
            } header: {
                Text("Facturation")
            }
        }
    }
}
