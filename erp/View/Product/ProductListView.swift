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

    var warehouse: Warehouse

    var body: some View {
        List {
            ForEach(warehouse.products) { product in
                NavigationLink {
                    ProductView(product: product)
                } label: {
                    ProductListItem(product: product)
                }
            }
        }
        .sheet(isPresented: $productCreateFormPresented) {
            NavigationStack {
                ProductCreateFormView(warehouse: warehouse)
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
            ToolbarItem(placement: .primaryAction) {
                Button {
                    productCreateFormPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ProductListView(warehouse: Warehouse(user: User(fullname: "First Last")))
}
