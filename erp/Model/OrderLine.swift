//
//  OrderLine.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData


@Model
final class OrderLine {

    var order: Order

    var variant: OrderVariant

    var quantity: Int

    init(order: Order, variant: OrderVariant, quantity: Int) {
        self.order = order
        self.variant = variant
        self.quantity = quantity
    }
}
