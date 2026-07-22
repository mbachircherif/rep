//
//  ProductOptionView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 17/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var optionToUpdate: ProductOption?

    var option: ProductOption

    private var valuesPreview: [ProductOptionValue] {
        Array(option.values.prefix(5))
    }

    var body: some View {
        List {
            Section {
                Text(option.name)
            } header: {
                Text("Détail")
            }

            Section {
                ForEach(valuesPreview) { value in
                    NavigationLink {
                        ProductOptionValueView(value: value)
                    } label: {
                        Text(value.name)
                    }
                }
            } header: {
                HStack {
                    Text("Valeurs")

                    Spacer()

                    NavigationLink {
                        
                    } label: {
                        Text("Voir tout")
                    }
                }
            }

            Section {
                Button("Supprimer", role: .destructive) {
                    delete()
                }
            }
        }
        .sheet(item: $optionToUpdate) { option in
            ProductOptionUpdateForm(option: option)
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    optionToUpdate = option
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
    }

    private func delete() {
        option.product?.options.removeAll { $0.id == option.id }
        try? modelContext.save()
        dismiss()
    }
}
