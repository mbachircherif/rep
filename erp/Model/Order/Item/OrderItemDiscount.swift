//
//  OrderItemDiscount.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 31/07/2026.
//

import Foundation
import SwiftData

@Model
final class OrderItemDiscount: Discount {

    var item: OrderVariant

    var name: String

    var type: ValueType

    var value: Decimal

    init(item: OrderVariant, name: String, type: ValueType, value: Decimal) {
        self.item  = item
        self.name  = name
        self.type  = type
        self.value = value
    }
}
