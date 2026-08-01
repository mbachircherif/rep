//
//  OrderCreateFormItemView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 01/08/2026.
//

import SwiftUI

struct OrderCreateFormItemView: View {

    var item: OrderFormItem

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 36.0) {
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
                    VStack(spacing: 12.0) {
                        HStack {
                            Text("Attributs")
                                .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()
                        }

                        Divider()
                            .overlay(Color(white: 0.9))
                            .padding(.horizontal, -12.0)

                        Grid(verticalSpacing: 4.0) {
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
                                        .padding(EdgeInsets(top: 8.0, leading: 12.0, bottom: 8.0, trailing: 12.0))
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
                                        .padding(EdgeInsets(top: 8.0, leading: 12.0, bottom: 8.0, trailing: 12.0))
                                        .background(Color(white: 0.975), in: .containerRelative)
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
                                        .padding(EdgeInsets(top: 8.0, leading: 12.0, bottom: 8.0, trailing: 12.0))
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
                    .overlay(Color(white: 0.935), in: .rect(cornerRadius: 24.0).stroke())
                }

                Section {
                    VStack(spacing: 12.0) {
                        HStack {
                            Text("Discounts")
                                .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(white: 0.20))

                            Spacer()

                            Image(systemName: "ellipsis")
                        }

                        Divider()
                            .overlay(Color(white: 0.9))
                            .padding(.horizontal, -12.0)

                        Grid(verticalSpacing: 4.0) {
                            GridRow {
                                HStack {
                                    Text("Winter 27")
                                        .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                        .foregroundStyle(.gray)

                                    Spacer()

                                    Text("-30%")
                                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(.indigo)
                                    //                                    .padding(EdgeInsets(top: 6.0, leading: 11.0, bottom: 6.0, trailing: 11.0))
                                    //                                    .background(.indigo.opacity(0.1), in: .capsule)
                                }
                                .padding(EdgeInsets(top: 8.0, leading: 12.0, bottom: 8.0, trailing: 12.0))
                            }

                            GridRow {
                                HStack {
                                    Text("Welcome")
                                        .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                        .foregroundStyle(.gray)

                                    Spacer()

                                    Text("-10%")
                                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(.indigo)
                                }
                                .padding(EdgeInsets(top: 8.0, leading: 12.0, bottom: 8.0, trailing: 12.0))
                                .background(Color(white: 0.975), in: .containerRelative)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white, in: .rect(cornerRadius: 24.0))
                    .overlay(Color(white: 0.935), in: .rect(cornerRadius: 24.0).stroke())
                }

                Section {
                    VStack(spacing: 0) {
                        VStack(spacing: 12.0) {
                            HStack {
                                Text("Summary")
                                    .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color(white: 0.20))

                                Spacer()
                            }

                            Divider()
                                .overlay(Color(white: 0.9))
                                .padding(.horizontal, -12.0)

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

                                Divider()
                                    .overlay(Color(white: 0.85))
                                    .padding(.horizontal, -12.0)

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
                    .background(Color(white: 0.92), in: .rect(cornerRadius: 24.0))
                }
            }
            .padding(24)
        }
        .background(Color(white: 0.95))
    }
}

#Preview {
    NavigationStack {
        OrderCreateFormItemView(item: OrderFormItem(from: ProductVariant(product: Product(warehouse: Warehouse(user: User(fullname: "Test Test")), name: "Analogue Pocket"), sku: "AP-BLK", position: 1), form: OrderCreateForm(currency: .eur)))
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
    }
}
