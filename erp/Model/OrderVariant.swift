//
//  OrderVariant.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import Foundation
import SwiftData

@Model
final class OrderVariant {

    var order: Order

    var reference: ProductVariant?

    var sku: String

    var name: String

    var attributes: [OrderVariantAttribute] = []

    var costPrice: Decimal

    var sellingPrice: Decimal

    var tax: Tax

    var stock: Stock

    var subtotal: Decimal {
        let total = total
        return total - (total * tax.rate)
    }

    var totalTaxes: Decimal {
        total * tax.rate
    }

    var total: Decimal {
        sellingPrice * stock.amount
    }

    init(reference: ProductVariant? = nil, order: Order, sku: String, name: String, attributes: [OrderVariantAttribute] = [], costPrice: Decimal, sellingPrice: Decimal, tax: Tax, stock: Stock) {
        self.order = order
        self.reference = reference
        self.sku = sku
        self.name = name
        self.attributes = attributes
        self.costPrice = costPrice
        self.sellingPrice = sellingPrice
        self.tax = tax
        self.stock = stock
    }
}

extension OrderVariant: Equatable {

    static func == (lhs: OrderVariant, rhs: OrderVariant) -> Bool {
        lhs.sku == rhs.sku
    }
}


extension OrderVariant: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(sku)
    }
}
