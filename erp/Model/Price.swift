//
//  Price.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 08/07/2026.
//

import Foundation

struct Price: Codable, Hashable {

    var amount: Decimal

    var currency: Currency
}
