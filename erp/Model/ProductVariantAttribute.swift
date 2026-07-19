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

    /// A variant attribute pairs a `ProductOption` with one of its `ProductOptionValue`s
    /// (e.g. Size → 1kg).
    ///
    /// **Invariant:** `value` must belong to `option`. In SQL this would be enforced by a
    /// composite foreign key `(option_id, value_id)`, but SwiftData cannot express that
    /// constraint. Instead, integrity is enforced at the application layer.
    ///
    /// - Warning: Never create or mutate this attribute directly; bypassing the validation
    ///   path can persist a value under the wrong option.

    #Unique<ProductVariantAttribute>([\.variant, \.optionValue])

    var variant: ProductVariant

    var optionValue: ProductOptionValue

    init(variant: ProductVariant, optionValue: ProductOptionValue) {
        self.variant = variant
        self.optionValue   = optionValue
    }
}
