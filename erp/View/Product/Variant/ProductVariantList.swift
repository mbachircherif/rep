//
//  ProductVariantList.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 25/07/2026.
//

import SwiftUI

struct ProductVariantList: View {

    var product: Product

    private var positionSortedVariants: [ProductVariant] {
        product.variants.sorted { $0.position < $1.position }
    }

    var body: some View {
        VStack {
            if product.variants.isEmpty {
                ContentUnavailableView {
                    Label("Aucun variant", systemImage: "tray.fill")
                        .fontDesign(.rounded)
                } description: {
                    Text("Commencez par ajouter des options pour créer de nouveaux variants.")
                        .fontDesign(.rounded)
                }
            } else {
                List {
                    ForEach(positionSortedVariants) { variant in
                        HStack {
                            let sortedAttributes = variant.attributes.sorted(by: { $0.position < $1.position })

                            Text(sortedAttributes.compactMap(\.optionValue?.name).joined(separator: "/"))

                            Spacer()

                            // TODO: Provide a default currency based on Locale
                            Text(variant.position, format: .number)
//                            Text(variant.sellingPrice, format: .currency(code: product.warehouse?.currency.rawValue ?? "EUR"))
                        }
                    }
                }
            }
        }
        .navigationTitle("Variantes")
        .navigationBarTitleDisplayMode(.inline)
    }
}
