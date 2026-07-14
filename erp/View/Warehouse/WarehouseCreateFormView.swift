//
//  WarehouseCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import SwiftUI

struct WarehouseCreateFormView: View {

    var warehouse: Warehouse

    var body: some View {
        @Bindable var warehouse = warehouse

        Form {
            Section {
                LabeledContent("Nom") {
                    TextField("Requis", text: $warehouse.name)
                }
            }

            Section {
                LabeledContent("Devise") {
                    Picker("Requis", selection: $warehouse.currency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.rawValue)
                                .tag(currency)
                        }
                    }
                }
            }
        }
    }
}
