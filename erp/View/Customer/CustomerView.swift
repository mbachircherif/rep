//
//  CustomerView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftUI

struct CustomerView: View {

    var customer: Customer

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20.0) {

                // Customer photo
                ContainerRelativeShape()
                    .fill(.gray.quinary)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 200.0)

                // First & Last names
                HStack(spacing: 20.0) {
                    Text(customer.firstName)
                        .font(.system(size: 13.0, design: .rounded))

                    Text(customer.lastName)
                        .font(.system(size: 13.0, design: .rounded))
                }

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
    }
}
