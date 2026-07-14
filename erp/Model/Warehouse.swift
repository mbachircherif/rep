//
//  Warehouse.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import SwiftData

@Model
final class Warehouse {

    @Attribute(.unique)
    var name: String

    var currency: Currency

    @Relationship(deleteRule: .cascade, inverse: \Product.warehouse)
    var products: [Product] = []

    @Relationship(deleteRule: .cascade, inverse: \Order.warehouse)
    var orders: [Order] = []

    init(name: String = "", currency: Currency = .usd) {
        self.name = name
        self.currency = currency
    }
}
