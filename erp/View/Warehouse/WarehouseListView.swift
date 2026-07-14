//
//  WarehouseListView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import SwiftData
import SwiftUI

struct WarehouseListView: View {

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var warehouseToCreate: Warehouse?

    var warehouses: [Warehouse]

    var body: some View {
        List {
            Section {
                ForEach(warehouses) { warehouse in
                    NavigationLink {
                        WarehouseView(warehouse: warehouse)
                    } label: {
                        Text(warehouse.name)
                    }
                }
            }
        }
        .sheet(item: $warehouseToCreate) { warehouse in
            NavigationStack {
                WarehouseCreateFormView(warehouse: warehouse)
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Créer") {
                                modelContext.insert(warehouse)
                                try? modelContext.save()
                                warehouseToCreate = nil
                            }
                        }

                        ToolbarItem(placement: .cancellationAction) {
                            Button(role: .cancel) {
                                warehouseToCreate = nil
                            }
                        }
                    }
            }
        }
        .navigationTitle("Entrepôts")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Nouveau") {
                    warehouseToCreate = Warehouse()
                }
            }
        }
    }
}
