//
//  erpApp.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import SwiftUI
import SwiftData

@main
struct erpApp: App {

    @State
    private var db = SwiftDataManager(model: try! ModelContainer(for: Schema([]), configurations: ModelConfiguration(schema: Schema([]), isStoredInMemoryOnly: true)))

    @State
    private var assistant = AssistantManager(tools: [CreateProductTool()])

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(db)
                .environment(\.assistant, assistant)
        }
    }
}
