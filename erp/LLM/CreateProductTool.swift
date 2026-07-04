//
//  CreateProductTool.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import FoundationModels

struct CreateProductTool: Tool {

    let name = "createProduct"

    let description = "Add a new product to the inventory."

    @Generable
    struct Arguments {

        @Guide(description: "Display name of the product")
        var name: String

        var price: Double
    }

    func call(arguments: Arguments) async throws -> String {
        "Created product \(arguments.name) at \(arguments.price)€."
    }
}
