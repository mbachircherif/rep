//
//  ProductOptionValue.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 17/07/2026.
//

import SwiftData

@Model
final class ProductOptionValue {

    #Unique<ProductOptionValue>([\.option, \.name])

    var option: ProductOption

    var name: String

    @Relationship(deleteRule: .cascade, inverse: \ProductVariantAttribute.value)
    var variantAttributes: [ProductVariantAttribute] = []

    init(option: ProductOption, name: String) {
        self.option = option
        self.name = name
    }
}
