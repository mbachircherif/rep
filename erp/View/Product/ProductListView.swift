//
//  ProductList.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData
import SwiftUI

struct ProductListView: View {

    @Environment(\.modelContext)
    private var modelContext

    @Query
    private var products: [Product]

    @State
    private var selectedProduct: Product?

    var body: some View {
        List {
            ForEach(products) { product in
                NavigationLink {
                    ProductView(product: product)
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
                    modelContext.insert(Product(name: "product_\(products.count)", price: .init(amount: 10.0, currency: .eur)))
                    try? modelContext.save()
                }
            }
        }
    }
}

#Preview {
    ProductListView()
}
