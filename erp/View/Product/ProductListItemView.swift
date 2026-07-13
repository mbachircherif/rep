//
//  ProductListItem.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftUI

struct ProductListItem: View {

    var product: Product

    var body: some View {
        HStack(spacing: 16.0) {

            // Image placeholder
            ContainerRelativeShape()
                .fill(.gray.quinary)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 50.0)

            Text(product.name)
                .fontDesign(.rounded)

            Spacer()

            Text("Variants: \(product.variants.count, format: .number)")
                .fontDesign(.rounded)
        }
    }
}
