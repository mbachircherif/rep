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

    var sku: String

    var product: Product

    var position: Int

    @Relationship(deleteRule: .cascade, inverse: \ProductVariantAttribute.variant)
    var attributes: [ProductVariantAttribute] = []

    var costPrice: Decimal

    var sellingPrice: Decimal

    var stock: Stock

    var tax: Tax

    init(
        sku: String = "",
        product: Product,
        position: Int,
        attributes: [ProductVariantAttribute] = [],
        costPrice: Decimal = 0,
        sellingPrice: Decimal = 0,
        tax: Tax = Tax(rate: 0, behavior: .inclusive),
        stock: Stock = Stock(amount: 0, unit: .quantity)
    ) {
        self.sku          = sku
        self.product      = product
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

extension ProductVariant {

    func copy() -> ProductVariant {
        ProductVariant(
            sku          : sku,
            product      : product,
            position     : position,
            attributes   : attributes.map { $0.copy() },
            costPrice    : costPrice,
            sellingPrice : sellingPrice,
            tax          : tax,
            stock        : stock
        )
    }
}
