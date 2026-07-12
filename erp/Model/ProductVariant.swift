//
//  ProductVariant.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData

@Model
@MainActor
final class ProductVariant: Variant {

    @Attribute(.unique)
    var sku: String

    var product: Product

    @Relationship(deleteRule: .cascade, inverse: \ProductVariantAttribute.variant)
    var attributes: [ProductVariantAttribute] = []

    var price: Price

    var stock: Stock

    init(sku: String, product: Product, attributes: [ProductVariantAttribute], price: Price, stock: Stock) {
        self.sku = sku
        self.product = product
        self.attributes = attributes
        self.price = price
        self.stock = stock
    }
}
