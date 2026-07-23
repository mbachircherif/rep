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
                NavigationLink {
                    ProductOptionValueList(option: option)
                } label: {
                    LabeledContent("Valeurs") {
                        Text(option.values.count, format: .number)
                    }
                }
            }

            Button {
                delete()
            } label: {
                Text("Supprimer")
                    .font(.system(size: 18.0, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.red)
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
        .navigationTitle(option.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func delete() {
        option.product?.options.removeAll { $0.id == option.id }
        try? modelContext.save()
        dismiss()
    }
}
