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

    @Attribute(.unique)
    var number: UUID = UUID()

    var customer: OrderCustomer

    @Relationship(deleteRule: .cascade, inverse: \OrderLine.order)
    var lines: [OrderLine] = []

    var status: Status

    var createdAt: Date = Date()

    init(customer: OrderCustomer, status: Status = .waiting) {
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
