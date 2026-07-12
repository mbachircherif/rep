//
//  OrderVariant.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

struct OrderVariant: Variant, Codable {

    var sku: String = ""

    var attributes: [OrderVariantAttribute] = []

    var price: Price

    var stock: Stock
}

extension OrderVariant: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(sku)
    }
}
