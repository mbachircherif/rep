//
//  ProductVariantAttribute.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData

@Model
@MainActor
final class ProductVariantAttribute: VariantAttribute, Sendable {

    #Unique<ProductVariantAttribute>([\.variant, \.key])

    var variant: ProductVariant

    var kind: AttributeKind

    var key: String

    var value: String

    init(variant: ProductVariant, kind: AttributeKind, key: String, value: String) {
        self.variant = variant
        self.kind = kind
        self.key = key
        self.value = value
    }
}
