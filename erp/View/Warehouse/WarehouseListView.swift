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

    var user: User

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(user.warehouses) { warehouse in
                    Button {
                        withAnimation(.snappy(duration: 0.25)) {
                            user.warehouse = warehouse
                        }
                    } label: {
                        // TODO: Extract.
                        VStack(alignment: .leading, spacing: 4.0) {
                            Image("nike")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.textPrimaryForeground)
                                .scaledToFit()
                                .frame(width: 30.0, height: 30.0)

                            Spacer()

                            Text(warehouse.name)
                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                .foregroundStyle(.textPrimaryForeground)

                            Text("\(warehouse.products.count, format: .number) produits")
                                .font(.system(size: 16.0, weight: .regular, design: .default))
                                .foregroundStyle(.textSecondary)
                        }
                        .aspectRatio(4/3, contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                        .background(.backgroundGreen, in: .containerRelative)
                    }
                    .buttonStyle(.plain)
                }
            }
            .containerShape(.rect(cornerRadius: 16.0))
            .padding()
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
                    warehouseToCreate = Warehouse(user: user)
                }
            }
        }
    }
}
