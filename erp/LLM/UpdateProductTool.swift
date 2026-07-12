//
//  UpdateProductTool.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 08/07/2026.
//

import FoundationModels

struct UpdateProductTool: Tool {

    let databaseManager: SwiftDataManager

    let name = "updateProduct"

    let description = "Update any information of an existing product except the name."

    @Generable
    struct Arguments {

        @Guide(description: "Display name of the product")
        var name: String

        @Guide(description: "Price of the product")
        var price: Double
    }

    func call(arguments: Arguments) async throws -> String {
        guard let product = try await databaseManager.fetch(Product.fetchOne(by: arguments.name)).first else {
            throw UpdateProductToolError.productNotFound(name: arguments.name)
        }

        await MainActor.run {
            product.price.amount = arguments.price
        }

        await databaseManager.unsafeSave()
        await databaseManager.sync()

        return "Updated product \(arguments.name)"
    }
}

enum UpdateProductToolError: Error {

    case productNotFound(name: String)
}
