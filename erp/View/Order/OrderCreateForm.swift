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

    var discounts: [OrderFormDiscount] = []

    var shipping: OrderFormShipping?

    var subtotal: Decimal {
        items.reduce(Decimal(0)) { $0 + $1.total }
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

        if let shipping {
            for tax in shipping.taxes {
                if let existingTax = taxesMap[tax] {
                    taxesMap[tax] = shipping.cost * tax.rate + existingTax
                } else {
                    taxesMap[tax] = shipping.cost * tax.rate
                }
            }
        }

        return taxesMap
    }

    var totalDiscount: Decimal {
        var base  : Decimal = subtotal
        var total : Decimal = 0

        // Apply discounts in cascade, accumulating the amount taken off at each step.
        for discount in discounts {
            let priceOff: Decimal
            switch discount.type {
            case .fixed:
                priceOff = discount.value
            case .percentage:
                priceOff = base * discount.value
            }

            total += priceOff
            base  -= priceOff
        }

        return total
    }

    var total: Decimal {
        var base: Decimal = 0

        for item in items {
            base += item.total
        }

        // Apply discounts in cascade
        for discount in discounts {
            switch discount.type {
            case .fixed:
                base -= discount.value
            case .percentage:
                base -= base * discount.value
            }
        }

        // Apply shipping
        if let shipping {
            base += shipping.cost
        }

        // Apply taxes
        // Apply product taxes
        for item in items {
            base += item.total * item.tax.rate
        }

        // Apply shipping taxes
        if let shipping {
            for tax in shipping.taxes {
                base += shipping.cost * tax.rate
            }
        }

        return base
    }

    var currency: Currency

    func priceOff(for discount: OrderFormDiscount) -> Decimal {
        switch discount.type {
        case .fixed:
            discount.value
        case .percentage:
            subtotal * discount.value
        }
    }

    init(currency: Currency) {
        self.currency = currency
    }
}

@Observable
final class OrderFormCustomer {

    var customerID: PersistentIdentifier

    var fullName: String

    init(from customer: Customer) {
        self.customerID = customer.id
        self.fullName   = customer.fullName
    }
}

@Observable
final class OrderFormItem: Identifiable, Hashable, Equatable {

    var id: PersistentIdentifier {
        reference.id
    }

    weak var form: OrderCreateForm?

    var reference: ProductVariant

    var name: String

    var sku: String

    var position: Int

    var costPrice: Decimal

    var sellingPrice: Decimal

    var quantity: Stock

    var stock: Stock

    var tax: Tax

    // Relations

    var attributes: [OrderFormItemAttribute] = []

    var discounts: [OrderFormItemDiscount] = []

    // Computed properties

    // TODO: Define what is a total and a subtotal for an item and an order.
    var subtotal: Decimal {
        sellingPrice / (1 + tax.rate) * quantity.amount
    }

    var total: Decimal {
        var base: Decimal = 0

        base += sellingPrice / (1 + tax.rate)

        // Cutting off discounts
        for discount in discounts {
            switch discount.type {
            case .fixed:
                base -= discount.value
            case .percentage:
                base -= discount.value * base
            }
        }

        base = base * quantity.amount

        return base
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

    func priceOff(for discount: OrderFormItemDiscount) -> Decimal {
        switch discount.type {
        case .fixed:
            discount.value * quantity.amount
        case .percentage:
            sellingPrice / (1 + tax.rate) * discount.value * quantity.amount
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(from productVariant: ProductVariant, form: OrderCreateForm, discounts: [OrderFormItemDiscount] = []) {
        self.form         = form
        self.reference    = productVariant
        self.name         = productVariant.product?.name ?? ""
        self.sku          = productVariant.sku
        self.position     = productVariant.position
        self.costPrice    = productVariant.costPrice
        self.sellingPrice = productVariant.sellingPrice
        self.quantity     = Stock(amount : 0, unit : productVariant.stock.unit)
        self.stock        = productVariant.stock
        self.tax          = productVariant.tax
        self.attributes   = productVariant.attributes
            .sorted { $0.position < $1.position }
            .map { OrderFormItemAttribute(key: $0.optionValue?.option?.name ?? "", value: $0.optionValue?.name ?? "", item: self) }
        self.discounts    = discounts
    }
}

@Observable
final class OrderFormItemAttribute: Hashable {

    weak var item: OrderFormItem?

    let key: String

    let value: String

    init(key: String, value: String, item: OrderFormItem) {
        self.item  = item
        self.key   = key
        self.value = value
    }

    static func == (lhs: OrderFormItemAttribute, rhs: OrderFormItemAttribute) -> Bool {
        lhs.key == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}

@Observable
final class OrderFormItemDiscount: Discount, Identifiable, Hashable {

    var id: String {
        name
    }

    var name: String

    var type: ValueType

    var value: Decimal

    init(name: String, type: ValueType, value: Decimal) {
        self.name  = name
        self.type  = type
        self.value = value
    }

    static func == (lhs: OrderFormItemDiscount, rhs: OrderFormItemDiscount) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

@Observable
final class OrderFormDiscount: Discount, Identifiable, Hashable {

    weak var form: OrderCreateForm?

    var id: String {
        name
    }

    var name: String

    var type: ValueType

    var value: Decimal

    init(form: OrderCreateForm, name: String, type: ValueType, value: Decimal) {
        self.form  = form
        self.name  = name
        self.type  = type
        self.value = value
    }

    static func == (lhs: OrderFormDiscount, rhs: OrderFormDiscount) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

@Observable
final class OrderFormShipping {

    weak var form: OrderCreateForm?

    var cost: Decimal

    var taxes: [Tax]

    init(form: OrderCreateForm?, cost: Decimal, taxes: [Tax]) {
        self.form  = form
        self.cost  = cost
        self.taxes = taxes
    }
}
