//
//  OrderVariantAttribute.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData

@Model
final class OrderVariantAttribute {

    var item: OrderVariant

    var key: String

    var value: String

    init(item: OrderVariant, key: String, value: String) {
        self.item  = item
        self.key   = key
        self.value = value
    }
}
