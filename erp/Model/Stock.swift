//
//  Stock.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import Foundation

struct Stock: Codable, Hashable {

    var amount: Decimal = 0

    var unit: Unit = .quantity
}
