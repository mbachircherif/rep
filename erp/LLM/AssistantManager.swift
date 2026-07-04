//
//  AssistantManager.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import Observation
import Foundation
import FoundationModels

@Observable
final class AssistantManager: Sendable {

    private let session: LanguageModelSession

    init(tools: [any Tool]) {
        self.session = LanguageModelSession(model: .default, tools: tools) {
            """
            You are an inventory assistant. You cannot create, modify, or sell \
            products yourself — you MUST use the provided tools to perform any action. \
            When the user asks to create a product, always call the createProduct tool.
            """
        }
    }

    func send(demand: String) async throws {
        try await session.respond(to: demand)
    }
}
