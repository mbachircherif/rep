//
//  OrderFormCustomerPicker.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 30/07/2026.
//

import SwiftData
import SwiftUI

// TODO: Naming ?
struct OrderCustomerPicker: View {

    let warehouse: Warehouse

    private var form: OrderCreateForm

    init(warehouse: Warehouse, form: OrderCreateForm) {
        self.warehouse = warehouse
        self.form = form
    }

    private var customers: [Customer] {
        warehouse.customers.sorted(using: SortDescriptor(\.fullName, comparator: .localizedStandard))
    }

    var body: some View {
        CustomerPicker(customers: customers) { customer in
            if form.customer?.customerID != customer.id {
                form.customer = OrderFormCustomer(from: customer)
            }
        } label: { customer in
            HStack(spacing: 16.0) {
                Image(systemName: "checkmark")
                    .opacity(form.customer?.customerID == customer.id ? 1 : 0)

                Text(customer.fullName)
            }
        }
    }
}

