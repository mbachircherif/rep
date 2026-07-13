//
//  OrderHubView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftData
import SwiftUI

struct OrderHubView: View {

    @Query
    private var orders: [Order]

    var body: some View {
        SearchView { query in
            OrderListView()
        }
    }
}
