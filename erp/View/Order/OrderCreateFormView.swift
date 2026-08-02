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
    private var form: OrderCreateForm

    @State
    private var selectedItemIndex: Int?

    @State
    private var selectedVariants: [ProductVariant] = []

    @State
    private var itemToDiscount: OrderFormItem?

    var warehouse: Warehouse

    init(warehouse: Warehouse) {
        self._form = State(wrappedValue: OrderCreateForm(currency: warehouse.currency))

        self.warehouse = warehouse
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 24.0) {
                // Customer
                /*
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
                 */

                // Variants
                ForEach(form.items.enumerated(), id: \.element) { index, item in
                    Section {
                        NavigationLink {
                            OrderCreateFormItemView(item: item)
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

                        // Discounts
                        ForEach(item.discounts) { discount in
                            LabeledContent(discount.name) {
                                Text(-item.priceOff(for: discount), format: .currency(code: form.currency.rawValue))
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                }

                /*
                 Section {
                 NavigationLink("Ajouter un variant") {
                 OrderProductVariantPicker(warehouse: warehouse, form: form, selectedVariants: $selectedVariants)
                 }
                 }
                 */
                Section {
                    VStack(alignment: .leading, spacing: 24.0) {
                        HStack {
                            Text("Client")
                                .font(.system(size: Constants.UI.sectionTitle, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()
                        }

                        Text("Sélectionner un client parmis votre portefeuille client.")
                            .font(.system(size: 16.0, weight: .regular, design: .rounded))
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white, in: .rect(cornerRadius: 16.0))

                        HStack(spacing: 12.0) {
                            Button {

                            } label: {
                                Image(systemName: "plus")
                            }
                            .buttonStyle(PrimaryIconButtonStyle())

                            Text("Sélectionner un client")
                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                        }
                    }
                }

                Divider()

                Section {
                    VStack(alignment: .leading, spacing: 24.0) {
                        HStack {
                            Text("Produit")
                                .font(.system(size: Constants.UI.sectionTitle, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()
                        }

                        Text("Ajouter les produits qui vous souhaitez vendre afin de les configurer.")
                            .font(.system(size: 16.0, weight: .regular, design: .rounded))
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white, in: .rect(cornerRadius: 16.0))

                        HStack(spacing: 12.0) {
                            Button {

                            } label: {
                                Image(systemName: "plus")
                            }
                            .buttonStyle(PrimaryIconButtonStyle())

                            Text("Ajouter un produit")
                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                        }
                    }
                }

                Divider()

                Section {
                    VStack(alignment: .leading, spacing: 24.0) {
                        HStack {
                            Text("Remises")
                                .font(.system(size: Constants.UI.sectionTitle, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()
                        }

                        Text("Ajouter des remises sur votre produit. Lorem ispum dolor si amet.")
                            .font(.system(size: 16.0, weight: .regular, design: .rounded))
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white, in: .rect(cornerRadius: 16.0))

                        HStack(spacing: 12.0) {
                            Button {

                            } label: {
                                Image(systemName: "plus")
                            }
                            .buttonStyle(PrimaryIconButtonStyle())

                            Text("Ajouter une remise")
                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                        }
                    }
                }

                Divider()

                Section {
                    VStack(alignment: .leading, spacing: 24.0) {
                        HStack {
                            Label("Livraison", systemImage: "shippingbox")
                                .font(.system(size: Constants.UI.sectionTitle, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()
                        }

                        Text("Ajouter une livraison à votre commande.")
                            .font(.system(size: 16.0, weight: .regular, design: .rounded))
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white, in: .rect(cornerRadius: 16.0))

                        HStack(spacing: 12.0) {
                            Button {

                            } label: {
                                Image(systemName: "plus")
                            }
                            .buttonStyle(PrimaryIconButtonStyle())

                            Text("Configurer une livraison")
                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                        }
                    }
                }

                Divider()

                //            Section {
                //                if let shipping = form.shipping {
                //                    NavigationLink {
                //                        OrderCreateFormShippingView(form: form)
                //                    } label: {
                //                        VStack {
                //                            LabeledContent("Frais de livraison", value: shipping.cost, format: .currency(code: form.currency.rawValue))
                //
                //                            ForEach(shipping.taxes, id: \.name) { tax in
                //                                LabeledContent(tax.name, value: tax.rate, format: .percent)
                //                            }
                //                        }
                //                    }
                //                } else {
                //                    NavigationLink("Ajouter des frais de livraison") {
                //                        OrderCreateFormShippingView(form: form)
                //                    }
                //                }
                //            }

                Section {
                    // Subtotal
                    LabeledContent("Sous-total (HT)", value: form.subtotal, format: .currency(code: form.currency.rawValue))


                    LabeledContent("Remises") {
                        Text(form.totalDiscount, format: .currency(code: form.currency.rawValue))
                            .foregroundStyle(.indigo)
                    }

                    if let shipping = form.shipping {
                        LabeledContent("Livraison") {
                            Text(shipping.cost, format: .currency(code: shipping.form?.currency.rawValue ?? ""))
                                .foregroundStyle(.yellow)
                        }
                    }

                    // Taxes
                    ForEach(Array(form.taxes), id: \.key) { tax, amount in
                        LabeledContent("TVA (\(tax.rate, format: .percent))", value: amount, format: .currency(code: warehouse.currency.rawValue))
                    }

                    // Total
                    LabeledContent("Total", value: form.total, format: .currency(code: warehouse.currency.rawValue))
                        .fontWeight(.medium)
                }
            }
            .padding(24.0)
        }
//        .scrollContentBackground(.hidden)
        .background(Color(white: 1))
        .safeAreaBar(edge: .bottom, spacing: 16.0) {
            if let selectedItemIndex {

                let selectedItem = form.items[selectedItemIndex]

                VStack {
                    HStack {
                        Spacer()

                        Button {
                            itemToDiscount = selectedItem
                        } label: {
                            Image(systemName: "seal.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18.0, height: 18.0)
                                .overlay {
                                    Text("%")
                                        .font(.footnote)
                                        .foregroundStyle(.white)
                                }
                        }
                        .buttonStyle(.glass)
                        .controlSize(.large)
                    }

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
                }
                .padding(.horizontal, 16.0)
            }
        }
        .sheet(item: $itemToDiscount) { item in
            NavigationStack {
                OrderCreateFormItemDiscountView(item: item)
            }
        }
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

            order.discounts = form.discounts.map {
                OrderDiscount(order: order, name: $0.name, type: $0.type, value: $0.value)
            }

            order.variants = form.items.map {
                let item = OrderVariant(
                    reference    : $0.reference,
                    order        : order,
                    sku          : $0.sku,
                    name         : $0.name,
                    costPrice    : $0.costPrice,
                    sellingPrice : $0.sellingPrice,
                    tax          : $0.tax,
                    quantity     : $0.quantity
                )

                item.attributes = $0.attributes.map {
                    OrderVariantAttribute(item: item, key: $0.key, value: $0.value)
                }

                item.discounts = $0.discounts.map {
                    OrderItemDiscount(item: item, name: $0.name, type: $0.type, value: $0.value)
                }

                if let shipping = form.shipping {
                    order.shipping = OrderShipping(
                        order: order,
                        cost:  shipping.cost,
                        taxes: shipping.taxes
                    )
                }

                return item
            }

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

#Preview {
    NavigationStack {
        OrderCreateFormView(warehouse: Warehouse(user: User(fullname: "Tes Test")))
            .navigationTitle("Commande")
            .navigationBarTitleDisplayMode(.inline)
    }
}
