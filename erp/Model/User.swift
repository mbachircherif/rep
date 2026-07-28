//
//  User.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 28/07/2026.
//

import SwiftData

@Model
final class User {

    @Attribute(.unique)
    var fullname: String = ""

    var warehouse: Warehouse?

    @Relationship(deleteRule: .cascade, inverse: \Warehouse.user)
    var warehouses: [Warehouse]

    init(fullname: String, warehouses: [Warehouse] = []) {
        self.fullname = fullname
        self.warehouses = warehouses
    }
}
