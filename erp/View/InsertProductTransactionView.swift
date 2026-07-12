//
//  InsertProductTransactionView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 08/07/2026.
//

import SwiftUI

struct InsertProductTransactionView: View {

    var product: Product

    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            ContainerRelativeShape()
                .fill(.gray.secondary)
                .aspectRatio(1, contentMode: .fit)

            VStack {
                Text(product.name)
                    .font(.system(size: 15.0, weight: .semibold, design: .rounded))
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(product.price.amount, format: .currency(code: product.price.currency.rawValue))
                    .font(.system(size: 13.0))

                Spacer()

                Text("200 pc")
                    .font(.system(size: 13.0, weight: .semibold, design: .rounded))
                    .foregroundStyle(.green)
                    .padding(6.0)
                    .background(.green.quinary, in: .containerRelative)
            }
        }
        .padding()
        .overlay(.green.tertiary, in: .rect(cornerRadius: 24.0).stroke())
    }
}

#Preview {
    InsertProductTransactionView(product: Product(name: "ESP 230", price: Price(amount: 630.0, currency: .eur)))
        .frame(height: 100.0)
        .padding()
}
