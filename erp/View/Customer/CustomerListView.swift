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

    @Query
    private var customers: [Customer]

    private var warehouse: Warehouse

    init(warehouse: Warehouse) {
        let warehouseID = warehouse.id

        var fetchCustomerDescriptor = FetchDescriptor<Customer>()
        fetchCustomerDescriptor.predicate = #Predicate { $0.warehouse?.persistentModelID == warehouseID }
        fetchCustomerDescriptor.sortBy = [SortDescriptor(\.fullName, comparator: .localizedStandard)]

        self._customers = Query(fetchCustomerDescriptor)
        self.warehouse = warehouse
    }

    var body: some View {
        List {
            ForEach(customers) { customer in
                NavigationLink {
                    CustomerView(customer: customer)
                } label: {
                    HStack(spacing: 16.0) {
                        ContainerRelativeShape()
                            .fill(.gray.quinary)
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: 50.0)

                        Text(customer.fullName)

                        Spacer()

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

