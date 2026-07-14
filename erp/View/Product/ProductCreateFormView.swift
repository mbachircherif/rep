//
//  ProductCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import SwiftData
import SwiftUI

struct ProductCreateFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @Environment(Warehouse.self)
    private var warehouse

    @State
    private var name: String = ""

    var body: some View {
        Form {
            Section {
                TextField("Nom", text: $name)
            }
        }
        .navigationTitle("Nouveau produit")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Ajouter") {
                    modelContext.insert(Product(warehouse: warehouse, name: name))
                    try? modelContext.save()
                    dismiss()
                }
                .buttonStyle(.glassProminent)
            }
        }
    }
}

