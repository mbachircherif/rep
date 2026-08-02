//
//  OrderCreateFormItemView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 01/08/2026.
//

import SwiftUI

struct OrderCreateFormItemView: View {

    @State
    private var discountToCreate: OrderFormItemDiscount?

    @State
    private var discountToUpdate: OrderFormItemDiscount?

    var item: OrderFormItem

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 48.0) {
                Image("pocket")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150.0, height: 150.0)
                    .background(Color(white: 0.92), in: .rect(cornerRadius: 16.0))

                VStack(spacing: 12.0) {
                    Text(item.name)
                        .font(.system(size: 16.0, weight: .semibold, design: .rounded))

                    Text(item.sku)
                        .font(.system(size: 13.0, weight: .regular, design: .monospaced))
                        .padding(EdgeInsets(top: 6.0, leading: 10.0, bottom: 6.0, trailing: 10.0))
                        .background(Color(white: 0.90), in: .capsule)
                }

                Section {
                    VStack(alignment: .leading, spacing: 12.0) {
                        HStack {
                            Text("Attributs")
                                .font(.system(size: Constants.UI.sectionTitle, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()
                        }
                        .padding(.horizontal)

                        VStack(spacing: 12.0) {
                            Grid(verticalSpacing: 12.0) {
                                ForEach(1...3, id: \.self) { index in
                                    Group {
                                        switch index {
                                        case 1:
                                            HStack {
                                                Text("Color")
                                                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                                    .foregroundStyle(.gray)

                                                Spacer()

                                                Text("White")
                                                    .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                                    .foregroundStyle(.black)
                                            }

                                            Divider()
                                                .overlay(Color(white: 0.85))
                                        case 2:
                                            HStack {
                                                Text("Size")
                                                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                                    .foregroundStyle(.gray)

                                                Spacer()

                                                Text("XL")
                                                    .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                                    .foregroundStyle(.black)
                                            }

                                            Divider()
                                                .overlay(Color(white: 0.85))
                                        case 3:
                                            HStack {
                                                Text("Fabric")
                                                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                                    .foregroundStyle(.gray)

                                                Spacer()

                                                Text("Velvet")
                                                    .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                                    .foregroundStyle(.black)
                                            }
                                        default:
                                            EmptyView()
                                        }
                                    }
                                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white, in: .rect(cornerRadius: 24.0))
                        .overlay(Color(white: 0.94), in: .rect(cornerRadius: 24.0).stroke())
                    }
                }

                Section {
                    VStack(alignment: .leading, spacing: 16.0) {
                        HStack {
                            Text("Remises")
                                .font(.system(size: Constants.UI.sectionTitle, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()

                            if !item.discounts.isEmpty {
                                Button {
                                    discountToCreate = OrderFormItemDiscount(
                                        name:  "",
                                        type:  .percentage,
                                        value: 0
                                    )
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundStyle(.gray)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)

                        if item.discounts.isEmpty {
                            Text("Ajouter des remises sur votre produit. Lorem ispum dolor si amet.")
                                .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                .foregroundStyle(.gray)
                                .padding(.horizontal)

                            Button("Ajouter une remise") {

                            }
                            .buttonStyle(SecondaryButtonStyle())
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                        } else {
                            Grid(verticalSpacing: 12.0) {
                                ForEach(item.discounts.enumerated(), id: \.element) { index, discount in
                                    if index > 0 {
                                        Divider()
                                            .overlay(Color(white: 0.85))
                                    }

                                    Button {
                                        discountToUpdate = discount
                                    } label: {
                                        GridRow {
                                            HStack(spacing: 12.0) {
                                                Image(systemName: "square.grid.3x2.fill")
                                                    .resizable()
                                                    .rotationEffect(.degrees(90))
                                                    .scaledToFit()
                                                    .frame(width: 15.0, height: 15.0)
                                                    .foregroundStyle(.gray.opacity(0.5))

                                                Text(discount.name)
                                                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                                    .foregroundStyle(.gray)

                                                Spacer()

                                                Group {
                                                    switch discount.type {
                                                    case .fixed:
                                                        Text(-discount.value, format: .currency(code: item.form?.currency.rawValue ?? "EUR"))
                                                    case .percentage:
                                                        Text(-discount.value, format: .percent)
                                                    }
                                                }
                                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                                .foregroundStyle(.indigo)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.white, in: .rect(cornerRadius: 24.0))
                            .overlay(Color(white: 0.94), in: .rect(cornerRadius: 24.0).stroke())
                        }

                        if !item.discounts.isEmpty {
                            // Footer
                            Text("L'application des remises se fait en cascade et par ordre de position.")
                                .font(.system(size: 14.0, weight: .regular, design: .rounded))
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                        }
                    }
                }

                Section {
                    VStack(alignment: .leading, spacing: 12.0) {
                        HStack {
                            Text("Summary")
                                .font(.system(size: Constants.UI.sectionTitle, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()
                        }
                        .padding(.horizontal)

                        VStack(spacing: 0) {
                            VStack(spacing: 12.0) {
                                Grid(verticalSpacing: 12.0) {
                                    GridRow {
                                        HStack {
                                            Text("Sous-total")
                                                .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                                .foregroundStyle(.gray)

                                            Spacer()

                                            Text("$189.00")
                                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                                .foregroundStyle(.black)
                                        }
                                    }

                                    Line()
                                        .stroke(Color(white: 0.9), style: StrokeStyle(lineWidth: 1, dash: [4, 4], dashPhase: 4))

                                    GridRow {
                                        HStack {
                                            Text("Remises")
                                                .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                                .foregroundStyle(.gray)

                                            Spacer()

                                            Text("-$39.80")
                                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                                .foregroundStyle(.indigo)
                                        }
                                    }

                                    Divider()
                                        .opacity(0)

                                    GridRow {
                                        HStack {
                                            Text("Taxes")
                                                .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                                .foregroundStyle(.gray)

                                            Spacer()

                                            Text("+$11.99")
                                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                                .foregroundStyle(.orange)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white, in: .containerRelative)

                            HStack {
                                Text("Total")
                                    .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                    .foregroundStyle(.gray)

                                Spacer()

                                Text("$238.79")
                                    .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical, 12.0)
                            .padding(.horizontal)
                        }
                        .padding(1.0)
                        .background(Color(white: 0.93), in: .rect(cornerRadius: 24.0))
                    }
                }
            }
            .padding(16.0)
        }
        .background(Color(white: 0.96))
        .sheet(item: $discountToCreate) { discount in
            NavigationStack {
                DiscountCreateForm { form in
                    discount.name  = form.name
                    discount.type  = form.type
                    discount.value = form.value

                    item.discounts.append(discount)

                    discountToCreate = nil
                }
            }
            .presentationDetents([.medium])
        }
        .sheet(item: $discountToUpdate) { discount in
            NavigationStack {
                DiscountUpdateView(discount: discount) { form in
                    discountToUpdate = nil
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Button(role: .destructive) {

                            } label: {
                                Label("Supprimer", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                }
            }
            .presentationDetents([.medium])
        }
        .sensoryFeedback(.selection, trigger: discountToCreate == nil)
        .sensoryFeedback(.selection, trigger: discountToUpdate == nil)
    }
}

#Preview {

    @Previewable
    @State
    var item = OrderFormItem(
        from: ProductVariant(
            product: Product(
                warehouse: Warehouse(
                    user: User(
                        fullname: "Test Test"
                    )
                ),
                name: "Analogue Pocket"
            ),
            sku: "AP-BLK",
            position: 1
        ),
        form: OrderCreateForm(
            currency: .eur
        ),
        discounts: [
//            OrderFormItemDiscount(
//                name:  "Winter 27",
//                type: .percentage,
//                value: 0.3
//            ),
//            OrderFormItemDiscount(
//                name:  "Welcome",
//                type: .fixed,
//                value: 10.0
//            )
        ]
    )

    NavigationStack {
        OrderCreateFormItemView(item: item)
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
    }
}
