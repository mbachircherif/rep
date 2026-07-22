//
//  ProductOptionList.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 22/07/2026.
//

import SwiftUI

struct ProductOptionList: View {

    @State
    private var optionToCreate: ProductOption?

    var product: Product

    var body: some View {
        List {
            ForEach(product.options) { option in
                NavigationLink {
                    ProductOptionView(option: option)
                } label: {
                    Text(option.name)
                }
            }
        }
        .sheet(item: $optionToCreate) { option in
            ProductOptionCreateForm(option: option)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    optionToCreate = ProductOption(product: product)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
