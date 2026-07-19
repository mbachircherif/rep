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
        .onAppear {
            print("INTERNAL FORM MODEL CONTEXT: \(Unmanaged.passUnretained(modelContext).toOpaque())")
        }
    }
}

