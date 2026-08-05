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
            VStack(spacing: 32.0) {
                VStack(spacing: 8.0) {
                    Text("Numéro")
                        .font(.system(size: 14.0, weight: .regular))
                        .foregroundStyle(.gray)

                    Text("#ORD-1")
                        .font(.system(size: 21, weight: .regular, design: .monospaced))
                }

                Spacer()

                VStack(spacing: 32.0) {
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
//                    Divider()

                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Client")
                                    .font(.system(size: Constants.UI.sectionTitle, weight: .medium))
                                    .foregroundStyle(Color(white: 0.20))

                                Spacer()
                            }
                            .padding(.horizontal)

                            /*
                             Text("Sélectionner un client parmis votre porte client.")
                             .font(.system(size: 16.0, weight: .regular, design: .rounded))
                             .foregroundStyle(.gray)
                             .background(.white, in: .rect(cornerRadius: 16.0))

                             HStack(spacing: 12.0) {
                             Button("Ajouter", systemImage: "plus") {}
                             .buttonStyle(SecondaryButtonStyle())
                             }
                             */
                            HStack(spacing: 16.0) {
                                Circle()
                                    .fill(Color(white: 0.95))
                                    .frame(width: 50.0, height: 50.0)

                                Text("OPAL Grand Lyon")
                                    .font(.system(size: 16.0, weight: .medium, design: .rounded))

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14.0, weight: .semibold))
                                    .foregroundStyle(Color(white: 0.75))
                            }
                            .padding(16.0)
                            .background(.white, in: .rect(cornerRadius: 24.0))
                        }
                    }

                    Section {
                        VStack(alignment: .leading) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("Produit")
                                    .font(.system(size: Constants.UI.sectionTitle, weight: .medium))
                                    .foregroundStyle(Color(white: 0.20))

                                Spacer()


                                Image(systemName: "plus")
                                    .foregroundStyle(.gray)
                            }
                            .padding(.horizontal)

                            VStack(alignment: .leading, spacing: 16.0) {
                                HStack(spacing: 16.0) {
                                    Image("waterdrop_bottle_2")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fill)
                                        .frame(width: 50.0, height: 50.0)
                                        .clipShape(.containerRelative)

                                    VStack(alignment: .leading, spacing: 4.0) {
                                        Text("Analogue Pocket")
                                            .font(.system(size: 16.0, weight: .medium, design: .rounded))

                                        Text("AP-BLK")
                                            .font(.system(size: 14.0, weight: .regular, design: .monospaced))
                                            .foregroundStyle(.gray)
                                    }

                                    Spacer()

                                    VStack(alignment: .trailing, spacing: 4.0) {
                                        Text(239.99, format: .currency(code: "EUR"))
                                            .font(.system(size: 16.0, weight: .medium, design: .rounded))

                                        Text("1 pc")
                                            .font(.system(size: 14.0, weight: .regular))
                                            .foregroundStyle(.gray)
                                    }

                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14.0, weight: .semibold))
                                        .foregroundStyle(Color(white: 0.75))
                                }

                                Divider()

                                HStack(spacing: 16.0) {
                                    Image("waterdrop_bottle_1")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fill)
                                        .frame(width: 50.0, height: 50.0)
                                        .clipShape(.containerRelative)

                                    VStack(alignment: .leading, spacing: 4.0) {
                                        Text("Analogue Pocket")
                                            .font(.system(size: 16.0, weight: .medium, design: .rounded))

                                        Text("AP-BLK")
                                            .font(.system(size: 14.0, weight: .regular, design: .monospaced))
                                            .foregroundStyle(.gray)
                                    }

                                    Spacer()

                                    VStack(alignment: .trailing, spacing: 4.0) {
                                        Text(239.99, format: .currency(code: "EUR"))
                                            .font(.system(size: 16.0, weight: .medium, design: .rounded))

                                        Text("1 pc")
                                            .font(.system(size: 14.0, weight: .regular))
                                            .foregroundStyle(.gray)
                                    }

                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14.0, weight: .semibold))
                                        .foregroundStyle(Color(white: 0.75))
                                }
                            }
                            .padding(16.0)
                            .background(.white, in: .rect(cornerRadius: 24.0))
                        }
                    }

                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Remises")
                                    .font(.system(size: Constants.UI.sectionTitle, weight: .medium))
                                    .foregroundStyle(Color(white: 0.20))

                                Spacer()

                                Image(systemName: "plus")
                                    .foregroundStyle(.gray)
                            }
                            .padding(.horizontal)

                            VStack(alignment: .leading, spacing: 16.0) {
                                HStack(spacing: 16.0) {
                                    Text("Winter")
                                        .font(.system(size: 16.0))
                                        .foregroundStyle(.gray)

                                    Text(23.0, format: .currency(code: "EUR"))
                                        .font(.system(size: 16.0, weight: .medium))
                                        .foregroundStyle(.black)
                                        .frame(maxWidth: .infinity, alignment: .trailing)

                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14.0, weight: .semibold))
                                        .foregroundStyle(Color(white: 0.75))
                                }

                                Divider()

                                HStack(spacing: 16.0) {
                                    Text("Welcome")
                                        .font(.system(size: 16.0))
                                        .foregroundStyle(.gray)

                                    Text(0.056, format: .percent)
                                        .font(.system(size: 16.0, weight: .medium))
                                        .foregroundStyle(.black)
                                        .frame(maxWidth: .infinity, alignment: .trailing)

                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14.0, weight: .semibold))
                                        .foregroundStyle(Color(white: 0.75))
                                }
                            }
                            .padding(16.0)
                            .background(.white, in: .rect(cornerRadius: 24.0))
                        }
                    }

                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Expédition")
                                    .font(.system(size: Constants.UI.sectionTitle, weight: .medium))
                                    .foregroundStyle(Color(white: 0.20))

                                Spacer()
                            }
                            .padding(.horizontal)

                            VStack(alignment: .leading, spacing: 24.0) {
                                HStack(spacing: 16.0) {
                                    VStack(alignment: .leading, spacing: 4.0) {
                                        Text("UPS")
                                            .font(.system(size: 16.0, weight: .medium))
                                            .foregroundStyle(Color(white: 0.25))

                                        Text("Livraison")
                                            .font(.system(size: 16.0))
                                            .foregroundStyle(.gray)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }

                                    Text(23.0, format: .currency(code: "EUR"))
                                        .font(.system(size: 16.0, weight: .medium))
                                        .frame(maxWidth: .infinity, alignment: .trailing)

                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14.0, weight: .semibold))
                                        .foregroundStyle(Color(white: 0.75))
                                }
                            }
                            .padding(16.0)
                            .background(.white, in: .rect(cornerRadius: 24.0))
                        }
                    }

//                    Divider()
//                        .overlay(Color(white: 0.9))

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
                }

                Section {
                    // Subtotal
                    Grid(verticalSpacing: 16.0) {
                        GridRow {
                            Text("Sous-total")
                                .font(.system(size: 16.0))
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(form.subtotal, format: .currency(code: form.currency.rawValue))
                                .font(.system(size: 16.0, weight: .medium))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        GridRow {
                            Text("Remise")
                                .font(.system(size: 16.0))
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(form.totalDiscount, format: .currency(code: form.currency.rawValue))
                                .font(.system(size: 16.0, weight: .medium))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        if let shipping = form.shipping {
                            GridRow {
                                Text("Livraison")
                                    .font(.system(size: 16.0))
                                    .foregroundStyle(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(shipping.cost, format: .currency(code: shipping.form?.currency.rawValue ?? ""))
                                    .font(.system(size: 16.0, weight: .medium))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }

                        Divider()

                        GridRow {
                            Text("Total")
                                .font(.system(size: 16.0, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(form.total, format: .currency(code: warehouse.currency.rawValue))
                                .font(.system(size: 16.0, weight: .semibold))
                                .foregroundStyle(.indigo)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }

                    // Taxes
                    ForEach(Array(form.taxes), id: \.key) { tax, amount in
                        LabeledContent("TVA (\(tax.rate, format: .percent))", value: amount, format: .currency(code: warehouse.currency.rawValue))
                    }
                }
                .padding(.horizontal)
            }
            .padding(16.0)
        }
        .background(Color(white: 0.95))
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
        .navigationTitle("Nouveau")
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
    }
}
