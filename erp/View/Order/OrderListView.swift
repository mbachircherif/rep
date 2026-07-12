//
//  OrderListView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct OrderListView: View {

    @Environment(SwiftDataManager.self)
    private var db

    var orders: [Order]

    @State
    private var selectedOrder: Order?

    @State
    private var orderForm: ModalState = .dismissed

    var body: some View {
        List {
            ForEach(orders) { product in
                Button {
                    selectedOrder = product
                } label: {
//                    ProductListItem(product: product)
                }
            }
        }
        .sheet(isPresented: Binding(get: { orderForm == .presented }, set: { orderForm = $0 ? .presented : .dismissed })) {
            OrderFormView()
        }
        .sheet(item: $selectedOrder) { order in
            NavigationStack {
//                ProductView(product: product)
            }
            .presentationDetents([.large])
        }
    }
}

#Preview {
    OrderListView(orders: [])
}

