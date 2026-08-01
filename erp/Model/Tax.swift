//
//  Tax.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import Foundation

struct Tax: Codable, Hashable {

    // TODO: Delete hardcoded name.
    var name: String = "TVA"

    var rate: Decimal

    var behavior: Behavior
}

extension Tax {

    enum Behavior: Codable, CaseIterable {

        case inclusive

        case exclusive
    }
}
