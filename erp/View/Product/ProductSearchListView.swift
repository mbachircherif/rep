//
//  ProductSearchListView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftUI

struct ProductSearchListView: View {

    @Environment(SwiftDataManager.self)
    private var db

    @State
    private var products: [Product] = []

    var body: some View {
        SearchView { query in
            ProductListView()
                .task(id: query) {
                    if query == "" {
                        products = []
                    } else {
                        products = (try? await db.fetch(Product.fetchMany(by: query))) ?? []
                    }
                }
        }
    }
}
