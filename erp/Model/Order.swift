//
//  Order.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import Foundation
import SwiftData

@Model
final class Order {

    var warehouse: Warehouse

    @Attribute(.unique)
    var number: UUID = UUID()

    var customer: OrderCustomer

    @Relationship(deleteRule: .cascade, inverse: \OrderVariant.order)
    var variants: [OrderVariant] = []

    var status: Status

    var createdAt: Date = Date()

    var subtotal: Decimal {
        variants.reduce(Decimal(0)) { $0 + $1.subtotal }
    }

    var totalTaxes: Decimal {
        variants.reduce(Decimal(0)) { $0 + $1.totalTaxes }
    }

    var total: Decimal {
        variants.reduce(Decimal(0)) { $0 + $1.total }
    }

    var taxes: [Tax : Decimal] {
        var taxesMap: [Tax: Decimal] = [:]

        for variant in variants {
            if let existingTax = taxesMap[variant.tax] {
                taxesMap[variant.tax] = variant.total * variant.tax.rate + existingTax
            } else {
                taxesMap[variant.tax] = variant.total * variant.tax.rate
            }
        }

        return taxesMap
    }

    init(warehouse: Warehouse, customer: OrderCustomer = .init(), status: Status = .waiting) {
        self.warehouse = warehouse
        self.customer = customer
        self.status = status
    }
}

extension Order {

    enum Status: Codable, CaseIterable {

        case waiting

        case paid

        case canceled
    }
}

extension Order {

    static var fetchAll: FetchDescriptor<Order> {
        FetchDescriptor<Order>()
    }
}
