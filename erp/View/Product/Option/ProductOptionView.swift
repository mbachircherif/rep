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

    @State
    private var optionValueToCreate: ProductOptionValue?

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
                        Text(value.name)

                        Spacer()

                        Menu {
                            NavigationLink {
                                ProductOptionValueView(value: value)
                                    .environment(\.modelContext, modelContext)
                            } label: {
                                Label("Modifier", systemImage: "pencil")
                            }

                            Divider()

                            Button(role: .destructive) {
                                option.values.remove(at: index)
                            } label: {
                                Label("Supprimer", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                        .containerShape(.rect)
                    }
                }

                Button("Ajouter une valeur") {
                    optionValueToCreate = ProductOptionValue(option: option)
                }
            }
        }
        .sheet(item: $optionValueToCreate) { optionValue in
            NavigationStack {
                ProductOptionValueCreateFormView(value: optionValue)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Sauvegarder") {
                    update()
                }
                .disabled(!modelContext.hasChanges)
            }
        }
    }

    private func update() {
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
