//
//  ProductOptionValueView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionValueView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var valueToUpdate: ProductOptionValue?

    var value: ProductOptionValue

    var body: some View {
        List {
            Section {
                Text(value.name)
            } header: {
                Text("Détail")
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
        .sheet(item: $valueToUpdate) { value in
            ProductOptionValueUpdateForm(value: value)
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    valueToUpdate = value
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .navigationTitle(value.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func delete() {
        value.option?.values.removeAll { $0.id == value.id }
        try? modelContext.save()
        dismiss()
    }
}
