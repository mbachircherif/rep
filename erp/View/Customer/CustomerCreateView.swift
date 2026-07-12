//
//  CustomerCreateView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct CustomerCreateView: View {

    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    var customer: Customer

    var body: some View {
        @Bindable var customer = customer

        Form {

            // Customer photo
            Section {
                ContainerRelativeShape()
                    .fill(.gray.quinary)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 150.0)
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
            }

            Section {
                TextField("First Name", text: $customer.firstName)

                TextField("Last Name", text: $customer.lastName)
            }

            Section {
                TextField("Email", text: $customer.email)

                TextField("Phone", text: $customer.phone)
            }

            Button("Create") {
                modelContext.insert(customer)
                try? modelContext.save()
                dismiss()
            }
        }
    }
}

