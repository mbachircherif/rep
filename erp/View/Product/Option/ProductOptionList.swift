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

    private var positionSortedOptions: [ProductOption] {
        product.options.sorted { $0.position < $1.position }
    }

    var body: some View {
        List {
            ForEach(positionSortedOptions) { option in
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
                    optionToCreate = ProductOption(product: product, position: product.options.count)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Options")
        .navigationBarTitleDisplayMode(.inline)
    }
}
