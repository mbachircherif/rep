//
//  WarehouseView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import SwiftUI

struct WarehouseView: View {

    var warehouse: Warehouse

    var body: some View {
        ProductListView(products: warehouse.products)
            .safeAreaBar(edge: .bottom) {
                NavigationLink {
                    OrderListView(orders: warehouse.orders)
                        .environment(warehouse)
                } label: {
                    Text("Commandes")
                }
            }
            .environment(warehouse)
    }
}
