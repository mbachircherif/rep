//
//  OrderListView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct OrderListView: View {

    @Environment(\.modelContext)
    private var modelContext

    @Environment(Warehouse.self)
    private var warehouse

    @State
    private var orderToCreate: Order?

    @State
    private var orderToUpdate: Order?

    @State
    var orders: [Order]

    var body: some View {
        List {
            Section {
                ForEach(orders) { order in
                    NavigationLink {
                        OrderView(order: order)
                    } label: {
                        LabeledContent("Numéro", value: order.number.uuidString)
                    }
                }
            } header: {
                Text("Ventes")
            }

            if orders.isEmpty {
                Text("Aucune commande n'a été créée pour l'instant.")
            }
        }
        .sheet(item: $orderToCreate) { order in
            NavigationStack {
                OrderCreateFormView(order: order)
                    .toolbar {
                        // Create button
                        ToolbarItem(placement: .primaryAction) {
                            Button("Créer") {
                                modelContext.insert(order)
                                try? modelContext.save()
                                orderToCreate = nil
                            }
                            .buttonStyle(.glassProminent)
                        }

                        // Dismiss button
                        ToolbarItem(placement: .cancellationAction) {
                            Button(role: .cancel) {
                                orderToCreate = nil
                            }
                        }
                    }
            }
        }
        .sheet(item: $orderToUpdate) { order in
            NavigationStack {
                OrderUpdateFormView(id: order.persistentModelID)
                    .environment(\.modelContext, ModelContext.appContext(modelContext.container))
                    .toolbar {
                        Button {
                            orderToUpdate = nil
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
            }
            .presentationDetents([.large])
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    orderToCreate = Order(warehouse: warehouse)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    OrderListView(orders: [])
}

