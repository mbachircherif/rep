//
//  ProductOptionValue.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 17/07/2026.
//

import SwiftData

@Model
final class ProductOptionValue {

    var option: ProductOption?

    var name: String

    var position: Int

    /// Uses `.nullify` deliberately: when a value is deleted, SwiftData sets
    /// `optionValue` to `nil` on the referencing `ProductVariantAttribute`s rather
    /// than deleting them. This keeps deletes from cascading into and destroying
    /// existing `ProductVariant`s, while still avoiding dangling references.
    ///
    /// - Warning: A nullified attribute now points at no value, leaving the variant
    ///   in an incomplete state. Callers should reassign or clean up such attributes
    ///   as part of the option/value lifecycle rather than relying on this rule alone.
    @Relationship(inverse: \ProductVariantAttribute.optionValue)
    var variantAttributes: [ProductVariantAttribute] = []

    init(option: ProductOption, name: String = "", position: Int) {
        self.option = option
        self.name = name
        self.position = position
    }
}
