//
//  OrderForm.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 29/07/2026.
//

import Foundation
import SwiftData

// TODO: Use Field structure.
@Observable
final class OrderCreateForm {

    var customer: OrderFormCustomer?

    var items: [OrderFormItem] = []

    var subtotal: Decimal {
        items.reduce(Decimal(0)) { $0 + $1.subtotal }
    }

    var taxes: [Tax : Decimal] {
        var taxesMap: [Tax: Decimal] = [:]

        for item in items {
            if let existingTax = taxesMap[item.tax] {
                taxesMap[item.tax] = item.total * item.tax.rate + existingTax
            } else {
                taxesMap[item.tax] = item.total * item.tax.rate
            }
        }

        return taxesMap
    }

    var total: Decimal {
        items.reduce(Decimal(0)) { $0 + $1.total }
    }
}

struct OrderFormCustomer {

    var customerID: PersistentIdentifier

    var fullName: String

    init(from customer: Customer) {
        self.customerID = customer.id
        self.fullName   = customer.fullName
    }
}

struct OrderFormItem: Identifiable, Hashable, Equatable {

    var id: PersistentIdentifier {
        reference.id
    }

    var reference: ProductVariant

    var name: String

    var sku: String

    var position: Int

    var attributes: [OrderFormItemAttribute] = []

    var costPrice: Decimal

    var sellingPrice: Decimal

    var quantity: Stock

    var stock: Stock

    var tax: Tax

    var subtotal: Decimal {
        (sellingPrice - (sellingPrice * tax.rate)) * quantity.amount
    }

    var total: Decimal {
        sellingPrice * quantity.amount
    }

    var canDecreaseQuantity: Bool {
        quantity.amount - 1 > -1
    }

    var canIncreaseQuantity: Bool {
        quantity.amount + 1 <= stock.amount
    }

    static func == (lhs: OrderFormItem, rhs: OrderFormItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(from productVariant: ProductVariant) {
        self.reference        = productVariant
        self.name             = productVariant.product?.name ?? ""
        self.sku              = productVariant.sku
        self.position         = productVariant.position
        self.attributes       = productVariant.attributes
            .sorted { $0.position < $1.position }
            .map { OrderFormItemAttribute(key: $0.optionValue?.option?.name ?? "", value: $0.optionValue?.name ?? "") }
        self.costPrice    = productVariant.costPrice
        self.sellingPrice = productVariant.sellingPrice
        self.quantity     = Stock(amount: 0, unit: productVariant.stock.unit)
        self.stock        = productVariant.stock
        self.tax          = productVariant.tax
    }
}

struct OrderFormItemAttribute: Hashable {

    let key: String

    let value: String
}
