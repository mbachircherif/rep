//
//  WarehouseView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import SwiftUI

struct WarehouseView: View {

    @State
    private var tab: NavigationTab = .dashboard

    var warehouse: Warehouse

    var body: some View {
        TabView(selection: $tab){
            Group {
                NavigationStack {
                    DashboardView(warehouse: warehouse)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                menu
                            }
                        }
                }
                .tag(NavigationTab.dashboard)

                NavigationStack {
                    ProductListView(warehouse: warehouse)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                menu
                            }
                        }
                }
                .tag(NavigationTab.product)

                NavigationStack {
                    OrderListView(warehouse: warehouse)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                menu
                            }
                        }
                }
                .tag(NavigationTab.order)

                NavigationStack {
                    CustomerListView(warehouse: warehouse)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                menu
                            }
                        }
                }
                .tag(NavigationTab.customer)
            }
            .toolbarVisibility(.hidden, for: .tabBar)
        }
    }

    private var menu: some View {
        Menu {
            Section("Menu") {
                Button("Synthèse", systemImage: "chart.pie.fill") {
                    tab = .dashboard
                }

                Button("Commandes", systemImage: "tray.fill") {
                    tab = .order
                }

                Button("Produits", systemImage: "tag.fill") {
                    tab = .product
                }

                Button("Clients", systemImage: "person.fill") {
                    tab = .customer
                }
            }

            Section {
                Button("Options", systemImage: "gear") {}
            }
        } label: {
            Image(systemName: "line.3.horizontal")
        }
    }
}
