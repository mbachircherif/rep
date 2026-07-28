//
//  CustomerListView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct CustomerListView: View {

    @Environment(\.modelContext)
    private var modelContex

    @State
    private var createCustomer: Customer?

    @State
    private var updateCustomer: Customer?

    var warehouse: Warehouse

    private var customers: [Customer] {
        warehouse.customers.sorted(using: SortDescriptor(\.fullName, comparator: .localizedStandard))
    }

    var body: some View {
        List {
            Text("Aucun client pour le moment")

            ForEach(customers) { customer in
                Button {
                    updateCustomer = customer
                } label: {
                    HStack(spacing: 16.0) {
                        ContainerRelativeShape()
                            .fill(.gray.quinary)
                            .frame(maxWidth: 75.0)
                            .aspectRatio(1, contentMode: .fit)

                        Text(customer.fullName)

                        Spacer()

                        Button {
                            modelContex.delete(customer)
                            try? modelContex.save()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                }
            }
        }
        .navigationTitle("Clients")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $createCustomer) { customer in
            NavigationStack {
                CustomerCreateFormView(customer: customer)
            }
        }
        .sheet(item: $updateCustomer) { customer in
            NavigationStack {
                CustomerUpdateFormView(id: customer.id)
                    .toolbar {
                        ToolbarItem(placement: .destructiveAction) {
                            Button {
                                updateCustomer = nil
                            } label: {
                                Image(systemName: "xmark")
                            }
                        }
                    }
            }
            .presentationDetents([.large])
        }
        .toolbar {
            // Add new customer button
            ToolbarItem(placement: .primaryAction) {
                Button {
                    createCustomer = Customer(warehouse: warehouse)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    CustomerListView(warehouse: Warehouse(user: User(fullname: "Goerge")))
}

