//
//  ProductOptionCreateFormView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 18/07/2026.
//

import SwiftData
import SwiftUI

struct ProductOptionCreateFormView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @Bindable
    var option: ProductOption

    var body: some View {
        Form {
            TextField("Requis", text: $option.name)
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(role: .cancel) {
                    dismiss()
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Créer") {
                    create()
                }
                .disabled(option.name.isEmpty)
            }
        }
    }

    private func create() {
        do {
            option.product.options.append(option)
            try modelContext.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
