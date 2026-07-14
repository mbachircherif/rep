//
//  Unit.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 08/07/2026.
//

import Foundation

enum Unit: Codable, CaseIterable {

    case quantity

    var symbol: String {
        switch self {
        case .quantity:
            return "Unité"
        }
    }
}
