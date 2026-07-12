//
//  Variant.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 08/07/2026.
//

import Foundation

protocol Variant {

    associatedtype Variant : VariantAttribute

    var sku: String { get set }

    var attributes: [Variant] { get set }

    var price: Price { get set }

    var stock: Stock { get set }
}
