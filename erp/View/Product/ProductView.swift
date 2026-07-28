//
//  ProductView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftData
import SwiftUI

struct ProductView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var productOptionToCreate: ProductOption?

    var product: Product

    var body: some View {
        List {
            Section {
                LabeledContent("Nom", value: product.name)
            } header: {
                Text("Détail")
            }

            Section {
                NavigationLink {
                    ProductOptionList(product: product)
                } label: {
                    LabeledContent("Options", value: product.options.count, format: .number)
                }
            }

            Section {
                NavigationLink {
                    ProductVariantList(product: product)
                } label: {
                    LabeledContent("Variants", value: product.variants.count, format: .number)
                }
            } footer: {
                Text("Les variantes sont générées automatiquement à partir des options du produit.")
            }

            Section {
                Button("Supprimer", role: .destructive) {}
            }
        }
    }

    private func delete() {
        do {
            modelContext.delete(product)
            try modelContext.save()
        } catch {

        }
    }
}
