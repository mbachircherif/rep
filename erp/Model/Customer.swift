//
//  Customer.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import Foundation
import SwiftData

@Model
final class Customer {

    #Index  <Customer>([\.fullName])
    #Unique <Customer>([\.fullName])

    var warehouse: Warehouse?

    var fullName: String

    var email: String

    var phone: String

    var createdAt: Date = Date()

    init(warehouse: Warehouse, fullName: String = "", email: String = "", phone: String = "") {
        self.warehouse = warehouse
        self.fullName  = fullName
        self.email     = email
        self.phone     = phone
    }
}
