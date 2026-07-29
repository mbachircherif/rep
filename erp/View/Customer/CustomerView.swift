//
//  CustomerView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct CustomerView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var customerToUpdate: Customer?

    var customer: Customer

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20.0) {
                // Customer photo
                ContainerRelativeShape()
                    .fill(.gray.quinary)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 50.0)

                // First & Last names
                Text(customer.fullName)
                    .font(.system(size: 13.0, design: .rounded))

                Section {
                    Text(customer.email)
                        .font(.system(size: 13.0, design: .rounded))
                } header: {
                    Text("Email")
                }

                Section {
                    Text(customer.phone)
                        .font(.system(size: 13.0, design: .rounded))
                } header: {
                    Text("Phone")
                }
            }
            .padding()
        }
        .sheet(item: $customerToUpdate) { customer in
            NavigationStack {
                CustomerUpdateFormView(customer: customer)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Section {
                        Button("Modifier", systemImage: "pencil") {
                            update(customer: customer)
                        }
                    }

                    Section {
                        Button("Supprimer", systemImage: "trash", role: .destructive) {
                            delete(customer: customer)
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }

    private func update(customer: Customer) {
        customerToUpdate = customer
    }

    private func delete(customer: Customer) {
        do {
            modelContext.delete(customer)
            try modelContext.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
