//
//  Product.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import Foundation
import SwiftData

@Model
final class Product: Sendable {

    var id: UUID = UUID()

    var name: String

    var price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}
