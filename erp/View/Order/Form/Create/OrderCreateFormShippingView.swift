//
//  OrderCreateFormShippingView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 01/08/2026.
//

import SwiftUI

struct OrderCreateFormShippingView: View {

    var form: OrderCreateForm

    var body: some View {
        Form {
            Section {
                if let shipping = form.shipping {
                    TextField("Frais", value: Bindable(shipping).cost, format: .currency(code: form.currency.rawValue))
                }
            }

            if let shipping = form.shipping {
                Section {
                    ForEach(Bindable(shipping).taxes, id: \.self) { $tax in
                        LabeledContent {
                            TextField("Requis", text: $tax.name)
                        } label: {
                            Text("Nom")
                        }

                        LabeledContent {
                            TextField("Requis", value: $tax.rate, format: .percent)
                        } label: {
                            Text("Taux")
                        }
                    }
                }
            }

            Section {
                if form.shipping == nil {
                    Button("Ajouter des frais de livraison") {
                        form.shipping = OrderFormShipping(
                            form: form,
                            cost: 0,
                            taxes: [
                                Tax(rate: 0, behavior: .inclusive)
                            ]
                        )
                    }
                } else {
                    Button("Supprimer les frais de livraison") {
                        form.shipping = nil
                    }
                }
            }
        }
        .navigationTitle("Livraison")
        .navigationBarTitleDisplayMode(.inline)
    }
}
