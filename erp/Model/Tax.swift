//
//  Tax.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 14/07/2026.
//

import Foundation

struct Tax: Codable, Hashable {

    var rate: Decimal

    var behavior: Behavior
}

extension Tax {

    enum Behavior: Codable, CaseIterable {

        case inclusive

        case exclusive
    }
}
