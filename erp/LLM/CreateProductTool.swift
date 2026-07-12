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

        @Generable
        struct Price {

            @Guide(description: "The price amount")
            let amount: Double

            @Guide(description: "The price currency")
            let currency: Currency
        }

        @Guide(description: "The price of the product")
        var price: Price
    }

    func call(arguments: Arguments) async throws -> String {
        await databaseManager.insert(Product(name: arguments.name, price: Price(amount: arguments.price.amount, currency: arguments.price.currency)))
        await databaseManager.unsafeSave()
        await databaseManager.sync()

        return "Created product \(arguments.name) at \(arguments.price)€."
    }
}
