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

    @State
    private var selectedProduct: Product?

    @State
    private var productCreateFormPresented: Bool = false

    var products: [Product]

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
        .sheet(isPresented: $productCreateFormPresented) {
            NavigationStack {
                ProductCreateFormView()
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(role: .cancel) {
                                productCreateFormPresented = false
                            }
                        }
                    }
            }
        }
        .sheet(item: $selectedProduct) { product in
            NavigationStack {
                ProductView(product: product)
            }
            .presentationDetents([.large])
        }
        .navigationTitle("Produits")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Nouveau") {
                    productCreateFormPresented = true
                }
            }
        }
    }
}

#Preview {
    ProductListView(products: [])
}
