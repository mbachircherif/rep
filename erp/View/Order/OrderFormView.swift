//
//  OrderFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import OrderedCollections
import SwiftData
import SwiftUI

struct OrderFormView: View {

    @Environment(SwiftDataManager.self)
    private var db

    @State
    private var selectedCustomer: Customer?

    @State
    private var selectedVariants: OrderedSet<OrderVariant> = []

    @Query
    private var products: [Product]

    @Query
    private var customers: [Customer]

    var body: some View {
        Form {
            ForEach(selectedVariants, id: \.sku) { variant in
                HStack {
                    Text(variant.sku)
                        .font(.system(size: 13.0, design: .default))

                    Button {
                        selectedVariants.remove(variant)
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
            }

            Section {
                NavigationLink("Select customer") {
                    List {
                        ForEach(customers) { customer in
                            Button {
                                selectedCustomer = customer
                            } label: {
                                Text(customer.fullName)
                            }
                        }
                    }
                }
            }

            NavigationLink("Add new variant") {
                List {
                    ForEach(products) { product in
                        DisclosureGroup(isExpanded: .constant(true)) {
                            ForEach(product.variants) { variant in

                                let orderVariant = OrderVariant(
                                    sku: variant.sku,
                                    attributes: variant.attributes.map {
                                        OrderVariantAttribute(key: $0.key, value: $0.value)
                                    },
                                    price: Price(amount: variant.price.amount, currency: variant.price.currency),
                                    stock: Stock(amount: variant.stock.amount, unit: variant.stock.unit)
                                )

                                let isSelected = selectedVariants.contains(orderVariant)

                                Button {
                                    if isSelected {
                                        selectedVariants.remove(orderVariant)
                                    } else {
                                        selectedVariants.append(orderVariant)
                                    }
                                } label: {
                                    HStack {
                                        Text(variant.sku)

                                        Spacer()

                                        if isSelected {
                                            Image(systemName: "check")
                                                .symbolVariant(.circle)
                                                .symbolVariant(.fill)
                                        }
                                    }
                                }
                            }
                        } label: {
                            ProductListItem(product: product)
                        }
                    }
                }
            }

            Button("Create") {
                if let selectedCustomer {

                    let order = Order(
                        customer: OrderCustomer(
                            firstName: selectedCustomer.firstName,
                            lastName:  selectedCustomer.lastName
                        ),
                        lines: selectedVariants.map {
                            OrderLine(
                                variant: $0,
                                quantity: 1
                            )
                        }
                    )

                    Task {
                        await db.insert(order)
                        await db.unsafeSave()
                    }
                }
            }
        }
    }
}
