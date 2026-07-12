//
//  OrderHubView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct OrderHubView: View {

    @Query
    private var orders: [Order]

    @State
    private var orderFormPresented: Bool

    var body: some View {
        SearchView { query in
            OrderListView(orders: orders)
        }
        .sheet(isPresented: $orderFormPresented) {
            NavigationStack {
                OrderFormView()
                    .toolbar {
                        Button {
                            orderFormPresented = false
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Order") {
                    orderFormPresented = false
                }
            }
        }
    }
}
