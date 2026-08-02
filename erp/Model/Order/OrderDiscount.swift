//
//  OrderDiscount.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 31/07/2026.
//

import Foundation
import SwiftData

@Model
final class OrderDiscount: Discount {

    var order: Order

    var name: String

    var type: ValueType

    var value: Decimal

    init(order: Order, name: String, type: ValueType, value: Decimal) {
        self.order = order
        self.name  = name
        self.type  = type
        self.value = value
    }
}

