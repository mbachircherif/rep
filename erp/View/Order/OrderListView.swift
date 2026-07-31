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

    @State
    private var isOrderCreatedFormPresented: Bool = false

    @Query
    private var orders: [Order]

    private var warehouse: Warehouse

    init(warehouse: Warehouse) {
        self._orders = Query(Order.fetchMany(warehouse: warehouse))

        self.warehouse = warehouse
    }

    var body: some View {
        List {
            Section {
                ForEach(warehouse.orders) { order in
                    NavigationLink {
                        OrderView(order: order)
                    } label: {
                        LabeledContent("Numéro", value: order.number.uuidString)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isOrderCreatedFormPresented) {
            NavigationStack {
                OrderCreateFormView(warehouse: warehouse)
            }
        }
        .navigationTitle("Commandes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isOrderCreatedFormPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    OrderListView(warehouse: Warehouse(user: User(fullname: "First Last")))
}

