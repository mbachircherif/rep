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

    @Query
    private var orders: [Order]

    @State
    private var selectedOrder: Order?

    @State
    private var createOrderFormPresented: Bool = false

    var body: some View {
        List {
            ForEach(orders) { order in
                Button {
                    selectedOrder = order
                } label: {
                    Text(order.id.debugDescription)
                }
            }

            if orders.isEmpty {
                Text("Aucune commande n'a été créée pour l'instant.")
            }
        }
        .sheet(isPresented: $createOrderFormPresented) {
            NavigationStack {
                OrderCreateFormView()
                    .toolbar {
                        Button {
                            createOrderFormPresented = false
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
            }
        }
        .sheet(item: $selectedOrder) { order in
            NavigationStack {
                OrderUpdateFormView(id: order.persistentModelID)
                    .environment(\.modelContext, ModelContext.appContext(modelContext.container))
                    .toolbar {
                        Button {
                            selectedOrder = nil
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
                    createOrderFormPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    OrderListView()
}

