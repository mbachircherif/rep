//
//  OrderLine.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData


@Model
final class OrderLine {

    var variant: OrderVariant

    var quantity: Int

    init (variant: OrderVariant, quantity: Int) {
        self.variant = variant
        self.quantity = quantity
    }
}
