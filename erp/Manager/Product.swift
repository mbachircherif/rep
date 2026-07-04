//
//  Product.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import Foundation
import SwiftData

@Model
final class Product {

    var id: UUID

    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
