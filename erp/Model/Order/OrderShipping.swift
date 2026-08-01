//
//  OrderShipping.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 01/08/2026.
//

import struct Foundation.Decimal
import SwiftData

@Model
final class OrderShipping {

    var order: Order

    var cost: Decimal

    var taxes: [Tax]

    init(order: Order, cost: Decimal, taxes: [Tax]) {
        self.order = order
        self.cost  = cost
        self.taxes = taxes
    }
}
