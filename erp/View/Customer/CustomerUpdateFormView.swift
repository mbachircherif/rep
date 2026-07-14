//
//  CustomerUpdateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct CustomerUpdateFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    var id: PersistentIdentifier

    var body: some View {
        UpdateModelView(type: Customer.self, id: id) { customer in
            @Bindable var customer = customer

            Form {

                // Customer photo
                Section {
                    ContainerRelativeShape()
                        .fill(.gray.quinary)
                        .aspectRatio(1, contentMode: .fit)
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

                Button("Update") {
                    try? modelContext.save()
                    dismiss()
                }
            }
        }
    }
}
