//
//  OrderCustomer.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData

@Model
final class OrderCustomer {

    var customer: Customer?

    var order: Order?

    var fullName: String

    init(fullName: String) {
        self.fullName = fullName
    }
}
