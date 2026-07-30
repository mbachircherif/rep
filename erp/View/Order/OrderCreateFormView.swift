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

    enum FieldKey {

        case customer
    }

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var form = OrderCreateForm()

    @State
    private var selectedItemIndex: Int?

    @State
    private var selectedVariants: [ProductVariant] = []

    var warehouse: Warehouse

    var body: some View {
        Form {
            // Customer
            Section {
                NavigationLink {
                    OrderCustomerPicker(warehouse: warehouse, form: form)
                } label: {
                    if let customer = form.customer {
                        Text(customer.fullName)
                    } else {
                        Text("Select a customer")
                    }
                }
            }

            // Variants
            Section {
                ForEach(form.items.enumerated(), id: \.element) { index, item in
                    Button {
                        withAnimation(.smooth) {
                            selectedItemIndex = index
                        }
                    } label: {
                        HStack(spacing: 16.0) {
                            ContainerRelativeShape()
                                .fill(.quinary)
                                .aspectRatio(1, contentMode: .fit)
                                .frame(maxWidth: 50.0)

                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(item.name)
                                    .foregroundStyle(.primary)
                                    .font(.default)
                                    .lineLimit(1)

                                Text(item.sku)
                                    .foregroundStyle(.secondary)
                                    .font(.footnote)
                                    .lineLimit(1)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 8.0) {
                                Text("\(item.subtotal, format: .currency(code: warehouse.currency.rawValue)) (HT)")
                                    .lineLimit(1)

                                Text("\(item.quantity.amount, format: .number) \(item.quantity.unit.symbol)")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                        }
                        .padding(12.0)
                        .background(.white, in: .containerRelative)
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(selectedItemIndex == index ? Color.blue : nil)
                    .listRowInsets(EdgeInsets(2.0))
                }

                NavigationLink("Ajouter un variant") {
                    OrderProductVariantPicker(warehouse: warehouse, form: form, selectedVariants: $selectedVariants)
                }
            }

            Section {
                // Subtotal
                LabeledContent("Sous-total (HT)", value: form.subtotal, format: .currency(code: warehouse.currency.rawValue))

                // Taxes
                ForEach(Array(form.taxes), id: \.key) { tax, amount in
                    LabeledContent("TVA (\(tax.rate, format: .percent))", value: amount, format: .currency(code: warehouse.currency.rawValue))
                }

                // Total
                LabeledContent("Total", value: form.total, format: .currency(code: warehouse.currency.rawValue))
                    .fontWeight(.medium)
            }
        }
        .safeAreaBar(edge: .bottom, spacing: 16.0) {
            if let selectedItemIndex {

                let selectedItem = form.items[selectedItemIndex]

                HStack {
                    Button {
                        if selectedItem.canDecreaseQuantity {
                            form.items[selectedItemIndex].quantity.amount -= 1
                        } else {
                            selectedVariants.remove(at: selectedItemIndex)
                            form.items.remove(at: selectedItemIndex)
                            self.selectedItemIndex = nil
                        }
                    } label: {
                        Image(systemName: selectedItem.canDecreaseQuantity ? "minus" : "trash")
                            .foregroundStyle(selectedItem.canDecreaseQuantity ? .black : .red)
                            .frame(width: 18.0, height: 18.0)
                    }
                    .buttonStyle(.glass)
                    .buttonBorderShape(.circle)
                    .controlSize(.large)

                    Spacer()

                    Button {

                    } label: {
                        Text(selectedItem.quantity.amount, format: .number)
                    }
                    .buttonStyle(.glass)
                    .controlSize(.large)

                    Spacer()

                    Button {
                        form.items[selectedItemIndex].quantity.amount += 1
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 18.0, height: 18.0)
                    }
                    .buttonStyle(.glass)
                    .buttonBorderShape(.circle)
                    .controlSize(.large)
                    .disabled(!selectedItem.canIncreaseQuantity)
                }
                .padding(.horizontal, 16.0)
            }
        }
        .listRowSpacing(16.0)
        .navigationTitle("Numéro de commande")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(role: .confirm) {
                    create()
                }
                .disabled(form.customer == nil || form.items.isEmpty)
            }

            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    cancel()
                }
            }
        }
    }

    private func cancel() {
        dismiss()
    }

    private func create() {
        do {
            guard let customer = form.customer else {
                throw FieldError<FieldKey>(field: .customer, reason: "Vous devez choisir un client")
            }

            let orderCustomer = OrderCustomer(fullName: customer.fullName)
            let order = Order(warehouse: warehouse, customer: orderCustomer)
            let orderItems = form.items.map {
                OrderVariant(
                    reference    : $0.reference,
                    order        : order,
                    sku          : $0.sku,
                    name         : $0.name,
                    costPrice    : $0.costPrice,
                    sellingPrice : $0.sellingPrice,
                    tax          : $0.tax,
                    quantity     : $0.quantity
                )
            }

            order.variants = orderItems

            // Update product variant quantity
            for item in form.items {
                item.reference.stock.amount -= item.quantity.amount
            }

            modelContext.insert(order)

            try modelContext.save()

            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
