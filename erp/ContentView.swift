//
//  ContentView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(AssistantManager.self)
    private var assistant

    @Environment(\.modelContext)
    private var modelContext

    @Environment(SwiftDataManager.self)
    private var dataManager

    @Query
    private var products: [Product]

    @State
    private var prompt: String = ""

    @State
    private var demandTask: LoadingTask<Void, Error> = .init(state: .waiting)

    @State
    private var recorder = SpeechRecorderManager()

    enum LoadingPhase {

        case idle

        case loading

        case success

        case failure
    }

    @State
    private var toggleRecordingTask: Task<Void, Error>?

    @State
    private var toggleRecordingLoadingState: LoadingPhase = .idle

    @State
    private var historyChanges: [DataOperationAction] = []

    enum Column: Identifiable {

        var id: Self { self }

        case customer

        case product

        case order

        case main
    }

    let columns: [Column] = [.product, .customer, .order]

    @State
    private var selectedColumn: Column = .product

    @Query
    private var warehouses: [Warehouse]

    var body: some View {
        NavigationStack {
            WarehouseListView(warehouses: warehouses)
        }
        /*
        NavigationSplitView {
            List {
                ForEach(columns) { column in
                    let backgroundColor: some ShapeStyle = selectedColumn == column ? .blue : .clear

                    Group {
                        switch column {
                        case .main:
                            Button("Main") {
                                selectedColumn = .main
                            }
                        case .customer:
                            Button("Clients") {
                                selectedColumn = .customer
                            }
                        case .product:
                            Button("Produits") {
                                selectedColumn = .product
                            }
                        case .order:
                            Button("Orders") {
                                selectedColumn = .order
                            }
                        }
                    }
                    .listRowBackground(Capsule().fill(backgroundColor))
                }
            }
        } detail: {
            switch selectedColumn {
            case .customer:
                CustomerListView()
            case .product:
                NavigationStack {
                    ProductListView()
                }
            case .order:
                OrderListView()
            case .main:
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(historyChanges.indices, id: \.self) { index in
                            let change = historyChanges[index]
                            
                            Group {
                                switch change {
                                case .delete(let model as Product):
                                    HStack {
                                        ContainerRelativeShape()
                                            .fill(.gray)
                                            .aspectRatio(1, contentMode: .fit)
                                        
                                        VStack {
                                            Text(model.name)
                                                .font(.system(size: 13.0))
                                            
                                            Text(model.price.amount, format: .number)
                                                .font(.system(size: 13.0))
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(.red.quinary, in: .containerRelative)
                                case .insert(let model as Product):
                                    InsertProductTransactionView(product: model)
                                case .update(let model as Product):
                                    HStack {
                                        ContainerRelativeShape()
                                            .fill(.gray)
                                            .aspectRatio(1, contentMode: .fit)
                                        
                                        VStack {
                                            Text(model.name)
                                                .font(.system(size: 13.0))
                                            
                                            Text(model.price.amount, format: .number)
                                                .font(.system(size: 13.0))
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(.orange.quinary, in: .containerRelative)
                                default:
                                    Text("Unknown intructions")
                                        .font(.system(size: 13.0))
                                }
                            }
                        }
                        .frame(height: 100.0)
                        .transition(.scale(scale: 0.5).combined(with: .opacity))
                        
                        switch demandTask.state {
                        case .running:
                            ProgressView()
                        case .failure:
                            Button {
                                // Retry
                            } label: {
                                Text("An error has occured during the operation\nTouch to retry.")
                                    .font(.system(size: 12.0))
                                    .foregroundStyle(.red)
                                    .padding(8.0)
                                    .background(.red.quinary, in: .containerRelative)
                                    .overlay(.red, in: .containerRelative)
                            }
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                }
                .safeAreaBar(edge: .bottom) {
                    HStack {
                        TextField("Formulez votre demande", text: $prompt)
                        
                        if prompt.isEmpty {
                            Button {
                                toggleRecordingTask = Task { try await recorder.toggle() }
                            } label: {
                                Image(systemName: recorder.isRecording ? "stop.circle.fill" : "microphone.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.black)
                            }
                            .disabled(toggleRecordingLoadingState == .loading)
                            .task(id: toggleRecordingTask) {
                                guard let toggleRecordingTask else { return }
                                
                                toggleRecordingLoadingState = .loading
                                
                                do {
                                    try await toggleRecordingTask.value
                                    print("Toggle Recording Success")
                                    toggleRecordingLoadingState = .success
                                } catch {
                                    print("Toggle Recording Failure \(error)")
                                    toggleRecordingLoadingState = .failure
                                }
                            }
                        } else {
                            Button {
                                demandTask.run {
                                    do {
                                        return .success(try await assistant.send(demand: prompt))
                                    } catch {
                                        return .failure(error)
                                    }
                                }
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    .padding(12.0)
                    .frame(height: 48.0)
                    .glassEffect(.regular, in: .capsule)
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .onTransactionChanges { action in
                    withAnimation(.smooth) {
                        historyChanges.append(action)
                    }
                }
            }
        }
         */
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
