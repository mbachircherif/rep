//
//  OrderVariantAttribute.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData

@Model
final class OrderVariantAttribute {

    var key: String

    var value: String

    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
