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

    var firstName: String

    var lastName: String

    var email: String

    var phone: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }

    private(set) var createdAt: Date = Date()

    init(firstName: String = "", lastName: String = "", email: String = "", phone: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
    }
}
