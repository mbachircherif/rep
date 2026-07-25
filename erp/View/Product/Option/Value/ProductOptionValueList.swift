//
//  ProductOptionValueList.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

import SwiftUI

struct ProductOptionValueList: View {

    @State
    private var valueToCreate: ProductOptionValue?

    var option: ProductOption

    private var positionSortedValues: [ProductOptionValue] {
        option.values.sorted { $0.position < $1.position }
    }

    var body: some View {
        List {
            ForEach(positionSortedValues) { value in
                NavigationLink {
                    ProductOptionValueView(value: value)
                } label: {
                    Text(value.name)
                }
            }
        }
        .sheet(item: $valueToCreate) { value in
            ProductOptionValueCreateForm(value: value)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    valueToCreate = ProductOptionValue(option: option, position: option.values.count)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Valeurs")
        .navigationBarTitleDisplayMode(.inline)
    }
}
