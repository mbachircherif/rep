//
//  ProductVariant.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import Foundation
import SwiftData

@Model
final class ProductVariant: Variant {

    @Attribute(.unique)
    var sku: String

    var product: Product

    @Relationship(deleteRule: .cascade, inverse: \ProductVariantAttribute.variant)
    var attributes: [ProductVariantAttribute] = []

    var costPrice: Decimal

    var sellingPrice: Decimal

    var stock: Stock

    var tax: Tax

    init(sku: String, product: Product, attributes: [ProductVariantAttribute], costPrice: Decimal, sellingPrice: Decimal, tax: Tax, stock: Stock) {
        self.sku = sku
        self.product = product
        self.attributes = attributes
        self.costPrice = costPrice
        self.sellingPrice = sellingPrice
        self.tax = tax
        self.stock = stock
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
