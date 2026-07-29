//
//  CustomerUpdateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct CustomerUpdateFormView: View {
    
    private enum FieldKey {
        
        case fullName, email, phone
    }

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var fullName: Field<FieldKey, String>

    @State
    private var email: Field<FieldKey, String>

    @State
    private var phone: Field<FieldKey, String>

    private var customer: Customer

    private var isFormValid: Bool {
        fullName.value.isEmpty == false && email.value.isEmpty == false && phone.value.isEmpty == false
    }

    init(customer: Customer) {
        self._fullName  = State(wrappedValue: Field(key: .fullName, value: customer.fullName))
        self._email     = State(wrappedValue: Field(key: .email, value: customer.email))
        self._phone     = State(wrappedValue: Field(key: .phone, value: customer.phone))
        
        self.customer = customer
    }
    
    var body: some View {
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
                TextField("Nom complet", text: $fullName.value)
            } footer: {
                if case let .error(reason) = fullName.state {
                    Label(reason, systemImage: "exclamationmark.circle.fill")
                        .foregroundStyle(.red)
                }
            }

            Section {
                TextField("E-mail", text: $email.value)
                TextField("Téléphone", text: $phone.value)
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    cancel()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button(role: .confirm) {
                    update()
                }
                .disabled(!isFormValid)
            }
        }
    }

    private func cancel() {
        dismiss()
    }

    private func update() {
        do {
            if let warehouse = customer.warehouse {
                // TODO: Use lowercase to compare ?
                // If so, create an index of a lowercase fullname.
                if fullName.value != customer.fullName, warehouse.customers.contains(where: { $0.fullName == fullName.value }) {
                    throw FieldError<FieldKey>(field: .fullName, reason: "Ce nom est déjà attribué à un autre client")
                }

                customer.fullName = fullName.value
                customer.email    = email.value
                customer.phone    = phone.value

                modelContext.insert(customer)

                try modelContext.save()
            }

            dismiss()
        } catch let error as FieldError<FieldKey> where error.field == .fullName {
            fullName.state = .error(reason: error.reason)
        } catch {
            print(error.localizedDescription)
        }
    }
}
