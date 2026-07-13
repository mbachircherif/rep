//
//  UpdateModelView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftData
import SwiftUI

struct UpdateModelView<T, Content>: View where T : PersistentModel, Content : View {

    @Environment(\.modelContext)
    private var modelContext

    let type: T.Type

    let id: PersistentIdentifier

    @ViewBuilder
    let content: (T) -> Content

    @State
    private var model: Result<T, Error>?

    var body: some View {
        switch model {
        case .none:
            Text("Retrieving the data")
                .onAppear {
                    do {
                        if let model = try modelContext.fetch(FetchDescriptor<T>(predicate: #Predicate { $0.persistentModelID == id })).first {
                            self.model = .success(model)
                        } else {
                            self.model = .failure(AppError.modelNotFound(id))
                        }
                    } catch {
                        model = .failure(error)
                    }
                }
        case .success(let model):
            content(model)
        case .failure(let error):
            Text("Failed to load the data: \(error.localizedDescription)")
        }
    }
}

