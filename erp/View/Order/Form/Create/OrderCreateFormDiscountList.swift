//
//  OrderCreateFormDiscountList.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 31/07/2026.
//

import SwiftUI

struct OrderCreateFormDiscountList: View {

    @State
    private var discountCreateFormPresented: Bool = false

    var form: OrderCreateForm

    var body: some View {
        List {
            Section {
                if form.discounts.isEmpty {
                    Text("Aucune réduction")
                } else {
                    ForEach(form.discounts.enumerated(), id: \.element) { index, discount in
                        HStack {
                            Button {
                                form.discounts.remove(at: index)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }

                            switch discount.type {
                            case .fixed:
                                LabeledContent(discount.name, value: discount.value, format: .currency(code: discount.form?.currency.rawValue ?? ""))
                            case .percentage:
                                LabeledContent(discount.name, value: discount.value, format: .percent)
                            }
                        }
                    }
                    .onMove { source, destination in
                        form.discounts.move(fromOffsets: source, toOffset: destination)
                    }
                }
            } header: {
                HStack {
                    Spacer()

                    EditButton()
                }
            } footer: {
                Text("Les réduction sont appliquées sur la commande totale.")
            }
        }
        .sheet(isPresented: $discountCreateFormPresented) {
            NavigationStack {
                DiscountCreateForm { form in
                    let discount = OrderFormDiscount(
                        form:  self.form,
                        name:  form.name,
                        type:  form.type,
                        value: form.value
                    )

                    self.form.discounts.append(discount)

                    discountCreateFormPresented = false
                }
            }
        }
        .navigationTitle("Réductions")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    discountCreateFormPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
