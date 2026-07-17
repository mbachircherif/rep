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

    var warehouse: Warehouse

    @Attribute(.unique)
    var name: String

    @Relationship(deleteRule: .cascade, inverse: \ProductOption.product)
    var options: [ProductOption] = []

    @Relationship(deleteRule: .cascade, inverse: \ProductVariant.product)
    var variants: [ProductVariant] = []

    init(warehouse: Warehouse, name: String) {
        self.warehouse = warehouse
        self.name = name
    }
}

extension Product {

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
