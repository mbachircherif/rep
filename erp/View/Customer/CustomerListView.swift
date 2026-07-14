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

    @Query
    private var customers: [Customer]

    @State
    private var createCustomer: Customer?

    @State
    private var updateCustomer: Customer?

    var body: some View {
        List {
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
        .sheet(item: $createCustomer) { customer in
            NavigationStack {
                CustomerCreateFormView(customer: customer)
                    .toolbar {
                        ToolbarItem(placement: .destructiveAction) {
                            Button {
                                createCustomer = nil
                            } label: {
                                Image(systemName: "xmark")
                            }
                        }
                    }
            }
            .presentationDetents([.large])
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
            ToolbarItem(placement: .topBarTrailing) {
                Button("New Client") {
                    createCustomer = Customer()
                }
            }
        }
    }
}

#Preview {
    CustomerListView()
}

