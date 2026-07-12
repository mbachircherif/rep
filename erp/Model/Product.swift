//
//  Product.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import Foundation
import SwiftData

@Model
@MainActor
final class Product: Sendable {

    @Attribute(.unique)
    var name: String

    var price: Price

    @Relationship(deleteRule: .cascade, inverse: \ProductVariant.product)
    var variants: [ProductVariant] = []

    init(name: String, price: Price) {
        self.name = name
        self.price = price
    }

    static func fetchOne(by name: String) -> FetchDescriptor<Product> {
        var descriptor = FetchDescriptor<Product>()

        descriptor.predicate = #Predicate { $0.name == name}
        descriptor.fetchLimit = 1

        return descriptor
    }

    static func fetchMany(by name: String) -> FetchDescriptor<Product> {
        var descriptor = FetchDescriptor<Product>()

        descriptor.predicate = #Predicate { $0.name == name}

        return descriptor
    }

    static func fetchMany(excluding skus: [String]) -> FetchDescriptor<Product> {
        var descriptor = FetchDescriptor<Product>()

        descriptor.predicate = #Predicate { product in
            product.variants.contains { variant in
                skus.contains(variant.sku)
            }
        }

        return descriptor
    }
}
