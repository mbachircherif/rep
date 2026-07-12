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

    var modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: Product.self, Customer.self, configurations: .init(for: Product.self, Customer.self, isStoredInMemoryOnly: true))
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
    }

    var body: some Scene {
        WindowGroup {
            LoadingView(modelContainer: modelContainer)
        }
        .modelContainer(modelContainer)
    }

    private struct LoadingView : View {

        var modelContainer: ModelContainer

        @State
        private var db: SwiftDataManager?

        @State
        private var assistant: AssistantManager?

        var body: some View {
            if let db, let assistant {
                ContentView()
                    .environment(db)
                    .environment(assistant)
            } else {
                ProgressView()
                    .task {
                        let manager = await SwiftDataManager(container: modelContainer)
                        db = manager
                        assistant = AssistantManager(tools: [CreateProductTool(databaseManager: manager)])
                    }
            }
        }
    }
}
