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

    var body: some View {
        List {
            ForEach(option.values) { value in
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
                    valueToCreate = ProductOptionValue(option: option)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Valeurs")
        .navigationBarTitleDisplayMode(.inline)
    }
}
