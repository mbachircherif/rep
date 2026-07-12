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
        Text(product.id.debugDescription)
    }
}
