//
//  OrderVariantAttribute.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

struct OrderVariantAttribute: VariantAttribute, Codable, Hashable {

    var kind: AttributeKind

    var key: String

    var value: String
}
