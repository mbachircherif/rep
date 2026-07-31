//
//  OrderCreateFormDiscountView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 31/07/2026.
//

import SwiftUI

struct OrderCreateFormDiscountView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var discountCreateFormPresented: Bool = false

    var form: OrderCreateForm

    var body: some View {
        List {
            Section {
                ForEach(form.discounts.enumerated(), id: \.element) { discountIndex, discount in
                    HStack(spacing: 16.0) {
                        Text(discount.name)

                        Spacer()

                        switch discount.type {
                        case .fixed:
                            Text(discount.value, format: .currency(code: form.currency.rawValue))
                        case .percentage:
                            Text(discount.value, format: .percent)
                        }

                        Button {
                            form.discounts.remove(at: discountIndex)
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
                DiscountCreateForm { discountForm in
                    let discount = OrderFormDiscount(
                        form:  form,
                        name:  discountForm.name,
                        type:  discountForm.type,
                        value: discountForm.value
                    )

                    form.discounts.append(discount)

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
