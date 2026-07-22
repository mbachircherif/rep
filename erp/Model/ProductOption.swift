//
//  ProductOption.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 17/07/2026.
//

import SwiftData

@Model
final class ProductOption {

    #Unique<ProductOption>([\.product, \.name])

    var product: Product?

    var name: String

    @Relationship(deleteRule: .cascade, inverse: \ProductOptionValue.option)
    var values: [ProductOptionValue] = []

    init(product: Product, name: String = "") {
        self.product = product
        self.name = name
    }
}
