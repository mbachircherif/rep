//
//  Warehouse.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import Foundation
import SwiftData

@Model
final class Warehouse {

    var user: User?

    @Attribute(.unique)
    var name: String

    var currency: Currency

    @Relationship(deleteRule: .cascade, inverse: \Customer.warehouse)
    var customers: [Customer] = []

    @Relationship(deleteRule: .cascade, inverse: \Product.warehouse)
    var products: [Product] = []

    @Relationship(deleteRule: .cascade, inverse: \Order.warehouse)
    var orders: [Order] = []

    init(user: User, name: String = "", currency: Currency = .usd) {
        self.user = user
        self.name = name
        self.currency = currency
    }
}
