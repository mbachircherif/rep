//
//  ProductList.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData
import SwiftUI

struct ProductListView: View {

    @Environment(SwiftDataManager.self)
    private var db

    var products: [Product]

    @State
    private var selectedProduct: Product?

    var body: some View {
        List {
            ForEach(products) { product in
                Button {
                    selectedProduct = product
                } label: {
                    ProductListItem(product: product)
                }
            }
        }
        .sheet(item: $selectedProduct) { product in
            NavigationStack {
                ProductView(product: product)
            }
            .presentationDetents([.large])
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") {
                    Task {
                        await db.insert(Product(name: "product_\(products.count)", price: .init(amount: 10.0, currency: .eur)))
                        await db.unsafeSave()
                    }
                }
            }
        }
    }
}

#Preview {
    ProductListView(products: [])
}
