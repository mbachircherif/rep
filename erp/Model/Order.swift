//
//  Order.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import Foundation
import SwiftData

@Model
@MainActor
final class Order: Sendable {

    var customer: OrderCustomer

    var lines: [OrderLine] = []

    var status: Status

    private(set) var createdAt: Date = Date()

    init(customer: OrderCustomer, lines: [OrderLine]) {
        self.customer = customer
        self.lines = lines
        self.status = .waiting
    }
}

extension Order {

    enum Status: Codable {

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
