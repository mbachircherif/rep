//
//  ProductVariantAttribute.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import Foundation
import SwiftData

@Model
final class ProductVariantAttribute {

    #Unique<ProductVariantAttribute>([\.variant, \.value])

    var variant: ProductVariant

    var value: ProductOptionValue

    init(variant: ProductVariant, value: ProductOptionValue) {
        self.variant = variant
        self.value   = value
    }
}

extension ProductVariantAttribute {

    static func fetchMany(by variant: ProductVariant) -> FetchDescriptor<ProductVariantAttribute> {
        var fetchDescriptor = FetchDescriptor<ProductVariantAttribute>()

        fetchDescriptor.predicate = #Predicate { $0.variant == variant }

        return fetchDescriptor
    }
}
