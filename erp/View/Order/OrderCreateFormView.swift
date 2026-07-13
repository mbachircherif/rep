//
//  OrderCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import OrderedCollections
import SwiftData
import SwiftUI

struct OrderCreateFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var customer: OrderCustomer?

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
                NavigationLink {
                    List {
                        ForEach(customers) { customer in
                            Button {
                                self.customer = OrderCustomer(firstName: customer.firstName, lastName: customer.lastName)
                            } label: {
                                HStack {
                                    Text(customer.fullName)

                                    Spacer()

                                    Image(systemName: "checkmark.circle.fill")
                                }
                            }
                        }
                    }
                } label: {
                    if let customer = customer {
                        Text("\(customer.firstName) \(customer.lastName)")
                    } else {
                        Text("Select a customer")
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
                                        OrderVariantAttribute(kind: $0.kind, key: $0.key, value: $0.value)
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
                if let customer {
                    let order = Order(customer: customer)
                    order.lines = selectedVariants.map { OrderLine(order: order, variant: $0, quantity: 1)}

                    modelContext.insert(order)
                    try? modelContext.save()
                }

                dismiss()
            }
        }
    }
}
