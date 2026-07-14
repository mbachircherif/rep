//
//  UpdateProductTool.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 08/07/2026.
//

import Foundation
import FoundationModels

struct UpdateProductTool: Tool {

    // TODO: Don't use this manager but the main actor context
    let databaseManager: SwiftDataManager

    let name = "updateProduct"

    let description = "Update any information of an existing product except the name."

    @Generable
    struct Arguments {

        @Guide(description: "Display name of the product")
        var name: String

        @Guide(description: "Price of the product")
        var price: Decimal
    }

    func call(arguments: Arguments) async throws -> String {
        guard let product = try await databaseManager.fetch(Product.fetchOne(by: arguments.name)).first else {
            throw UpdateProductToolError.productNotFound(name: arguments.name)
        }

        await databaseManager.unsafeSave()
        await databaseManager.sync()

        return "Updated product \(arguments.name)"
    }
}

enum UpdateProductToolError: Error {

    case productNotFound(name: String)
}
