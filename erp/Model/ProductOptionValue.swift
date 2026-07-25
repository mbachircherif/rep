//
//  ProductOptionValue.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 17/07/2026.
//

import SwiftData

@Model
final class ProductOptionValue {

    #Unique<ProductOptionValue>([\.option, \.name])

    var option: ProductOption?

    var name: String

    var position: Int

    init(option: ProductOption, name: String = "", position: Int) {
        self.option = option
        self.name = name
        self.position = position
    }
}
