//
//  Discount.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 31/07/2026.
//

import Foundation
import SwiftData

@Model
final class WarehouseDiscount: Discount {

    var warehouse: Warehouse

    @Attribute(.unique)
    var name: String

    var type: ValueType

    var value: Decimal

    init(warehouse: Warehouse, name: String, type: ValueType, value: Decimal) {
        self.warehouse = warehouse
        self.name      = name
        self.type      = type
        self.value     = value
    }
}
