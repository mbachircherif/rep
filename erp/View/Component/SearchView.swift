//
//  SearchView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

import SwiftUI

struct SearchView<Content> : View where Content : View {

    @State
    private var query: String = ""

    @ViewBuilder
    var content: (String) -> Content

    var body: some View {
        content(query)
            .searchable(text: $query)
    }
}
