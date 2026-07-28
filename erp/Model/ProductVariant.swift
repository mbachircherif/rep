//
//  ProductVariant.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import Foundation
import SwiftData

@Model
final class ProductVariant {

    /// Indexing  on (product, position) is a list that groups by product and sort by position:
    /// (ProductA, 1) → row 47
    /// (ProductA, 2) → row 12
    /// (ProductA, 3) → row 88
    /// (ProductB, 1) → row 03
    /// (ProductB, 2) → row 51
    #Index<ProductVariant>([\.product, \.position])

    var product: Product?

    var sku: String

    var position: Int

    @Relationship(deleteRule: .cascade, inverse: \ProductVariantAttribute.variant)
    var attributes: [ProductVariantAttribute] = []

    var costPrice: Decimal

    var sellingPrice: Decimal

    var stock: Stock

    var tax: Tax

    init(
        product: Product?,
        sku: String = "",
        position: Int,
        attributes: [ProductVariantAttribute] = [],
        costPrice: Decimal = 0,
        sellingPrice: Decimal = 0,
        tax: Tax = Tax(rate: 0, behavior: .inclusive),
        stock: Stock = Stock(amount: 0, unit: .quantity)
    ) {
        self.product      = product
        self.sku          = sku
        self.position     = position
        self.attributes   = attributes
        self.costPrice    = costPrice
        self.sellingPrice = sellingPrice
        self.tax          = tax
        self.stock        = stock
    }
}

extension ProductVariant: Equatable {

    static func == (lhs: ProductVariant, rhs: ProductVariant) -> Bool {
        lhs.sku == rhs.sku
    }
}

extension ProductVariant: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(sku)
    }
}
