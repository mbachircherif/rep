//
//  CreateProductTool.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import FoundationModels

struct CreateProductTool: Tool {

    let databaseManager: SwiftDataManager

    let name = "createProduct"

    let description = "Add a new product to the inventory."

    @Generable
    struct Arguments {

        @Guide(description: "Display name of the product")
        var name: String

        var price: Double
    }

    func call(arguments: Arguments) async throws -> String {
        await databaseManager.insert(Product(name: arguments.name, price: arguments.price))
        await databaseManager.unsafeSave()
        await databaseManager.sync()

        return "Created product \(arguments.name) at \(arguments.price)€."
    }
}
