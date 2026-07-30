//
//  CustomerPicker.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 30/07/2026.
//

import SwiftUI

struct CustomerPicker<Label>: View where Label : View {

    let customers: [Customer]

    let onPick: (Customer) -> Void

    @ViewBuilder
    let label: (Customer) -> Label

    var body: some View {
        List {
            ForEach(customers) { customer in
                Button {
                    onPick(customer)
                } label: {
                    label(customer)
                }
            }
        }
    }
}
