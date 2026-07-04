//
//  Environment+Assistant.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

import SwiftUI

extension EnvironmentValues {

    @Entry
    var assistant: AssistantManager = AssistantManager(tools: [CreateProductTool()])
}
