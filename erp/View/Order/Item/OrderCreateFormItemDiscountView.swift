//
//  OrderCreateFormItemDiscountView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 31/07/2026.
//

import SwiftUI

struct OrderCreateFormItemDiscountView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var discountCreateFormPresented: Bool = false

    var item: OrderFormItem

    var body: some View {
        List {
            Section {
                ForEach(item.discounts.enumerated(), id: \.element) { discountIndex, discount in
                    HStack(spacing: 16.0) {
                        Text(discount.name)

                        Spacer()

                        switch discount.type {
                        case .fixed:
                            Text(discount.value, format: .currency(code: item.form?.currency.rawValue ?? ""))
                        case .percentage:
                            Text(discount.value, format: .percent)
                        }

                        Button {
                            item.discounts.remove(at: discountIndex)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }

                Button("Ajouter une réduction") {
                    discountCreateFormPresented = true
                }
            }
        }
        .sheet(isPresented: $discountCreateFormPresented) {
            NavigationStack {
                DiscountCreateForm { form in
                    let discount = OrderFormItemDiscount(
                        name:  form.name,
                        type:  form.type,
                        value: form.value
                    )

                    item.discounts.append(discount)

                    discountCreateFormPresented = false
                }
            }
        }
        .navigationTitle("Réductions")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button(role: .confirm) {
                    dismiss()
                }
            }
        }
    }
}
