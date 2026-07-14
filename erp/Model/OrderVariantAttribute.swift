//
//  OrderVariantAttribute.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData

@Model
final class OrderVariantAttribute: VariantAttribute {

    var kind: AttributeKind

    var key: String

    var value: String

    init(kind: AttributeKind, key: String, value: String) {
        self.kind = kind
        self.key = key
        self.value = value
    }
}
