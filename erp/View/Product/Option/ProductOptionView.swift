//
//  ProductOptionView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 17/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionView: View {

    @Environment(\.modelContext)
    private var modelContext

    var option: ProductOption

    var body: some View {
        List {
            Section {
                Text(option.name)
            } header: {
                Text("Détail")
            }

            Section {
                ForEach(option.values.enumerated(), id: \.element) { index, value in
                    HStack {
                        Text(value.value)

                        Spacer()

                        Button {
                            option.values.remove(at: index)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Update") {
                    // TODO: Make bulk update easier.
                    for variant in option.product.variants {
                        for attribute in variant.attributes {
                            if attribute.name == option.name {
                                attribute.name = option.name
                            }
                        }
                    }

                    try? modelContext.save()
                }
                .disabled(!modelContext.hasChanges)
            }
        }
    }
}
