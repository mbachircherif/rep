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

    @Query
    private var products: [Product]

    @Query
    private var customers: [Customer]

    var order: Order

    var body: some View {
        Form {
            Section {
                ForEach(order.variants.enumerated(), id: \.element) { index, variant in
                    NavigationLink {
                        OrderVariantView(variant: variant)
                            .onDelete {
                                order.variants.remove(at: index)
                            }
                    } label: {
                        HStack(spacing: 16.0) {
                            ContainerRelativeShape()
                                .fill(.quinary)
                                .aspectRatio(1, contentMode: .fit)
                                .frame(maxWidth: 50.0)

                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(variant.name)
                                    .foregroundStyle(.primary)
                                    .font(.default)
                                    .lineLimit(1)

                                Text(variant.sku)
                                    .foregroundStyle(.secondary)
                                    .font(.footnote)
                                    .lineLimit(1)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 8.0) {
                                Text("\(variant.subtotal, format: .currency(code: order.warehouse.currency.rawValue)) (HT)")
                                    .lineLimit(1)

                                Text("\(variant.stock.amount, format: .number) \(variant.stock.unit.symbol)")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                }

                NavigationLink("Ajouter un variant") {
                    List {
                        ForEach(products) { product in
                            DisclosureGroup(isExpanded: .constant(true)) {
                                ForEach(product.variants) { variant in

                                    let isSelected = order.variants.contains { $0.sku == variant.sku }

                                    Button {
                                        if isSelected {
                                            order.variants.removeAll { $0.sku == variant.sku }
                                        } else {
                                            let orderVariant = OrderVariant(
                                                reference: variant,
                                                order: order,
                                                sku: variant.sku,
                                                name: product.name,
                                                attributes: []/*variant.attributes.map {
                                                    OrderVariantAttribute(kind: $0.kind, key: $0.key, value: $0.value)
                                                }*/,
                                                costPrice: variant.costPrice,
                                                sellingPrice: variant.sellingPrice,
                                                tax: Tax(rate: variant.tax.rate, behavior: variant.tax.behavior),
                                                stock: Stock(amount: 1, unit: variant.stock.unit)
                                            )
                                            order.variants.append(orderVariant)
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
            }

            Section {
                NavigationLink {
                    List {
                        ForEach(customers) { customer in
                            Button {
                                order.customer.firstName = customer.firstName
                                order.customer.lastName  = customer.lastName
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
                    if order.customer.firstName.isEmpty && order.customer.lastName.isEmpty {
                        Text("Select a customer")
                    } else {
                        Text("\(order.customer.firstName) \(order.customer.lastName)")
                    }
                }
            }

            Section {
                DisclosureGroup(isExpanded: .constant(true)) {
                    ForEach(Array(order.taxes), id: \.key) { tax, amount in
                        LabeledContent("TVA (\(tax.rate, format: .percent))", value: amount, format: .currency(code: order.warehouse.currency.rawValue))
                    }
                } label: {
                    LabeledContent("Sous-total (HT)", value: order.subtotal, format: .currency(code: order.warehouse.currency.rawValue))
                }

                LabeledContent("Total", value: order.total, format: .currency(code: order.warehouse.currency.rawValue))
                    .fontWeight(.medium)
            }
        }
        .navigationTitle("Numéro de commande")
        .navigationBarTitleDisplayMode(.inline)
    }
}
