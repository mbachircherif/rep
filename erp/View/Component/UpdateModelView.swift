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

struct FetchModelView<T, Content>: View where T : PersistentModel, Content : View {

    @State
    private var model: Result<T?, Error>?

    @State
    private var modelContext: ModelContext

    let type: T.Type

    let id: PersistentIdentifier

    let content: (T) -> Content

    // TODO: The ModelContext building must be decorelated from this view. Put that logic outside.
    init(type: T.Type, id: PersistentIdentifier, container: ModelContainer, @ViewBuilder content: @escaping (T) -> Content) {
        self.type = type
        self._modelContext = State(wrappedValue: ModelContext(container, autosave: false))
        self.id = id
        self.content = content
    }

    var body: some View {
        switch model {
        case .none:
            ProgressView()
                .onAppear {
                    do {
                        if let model = try modelContext.fetch(FetchDescriptor<T>(predicate: #Predicate { $0.persistentModelID == id })).first {
                            self.model = .success(model)
                        } else {
                            self.model = .success(nil)
                        }
                    } catch {
                        model = .failure(error)
                    }
                }
        case .success(.some(let model)):
            content(model)
                .environment(\.modelContext, modelContext)
        case .success(.none), .failure:
            ContentUnavailableView {
                Label("Not found", systemImage: "exclamationmark.magnifyingglass")
            } description: {
                Text("Choose a country to see more details here.")
            }
        }
    }
}
