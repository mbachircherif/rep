//
//  ProductOptionValueView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 17/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionValueView: View {

    @Environment(\.modelContext)
    private var modelContext

    @Bindable
    var value: ProductOptionValue

    var body: some View {
        List {
            Section {
                TextField("Required", text: $value.name)
            } header: {
                Text("Détail")
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Update") {
                    // TODO: Make bulk update easier.
                    for variant in value.option.product.variants {
                        for attribute in variant.attributes {
                            if attribute.name == value.option.name {
                                if attribute.name == value.name {
                                    attribute.name = value.name
                                }
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

