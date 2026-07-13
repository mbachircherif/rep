//
//  Currency.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 08/07/2026.
//

import FoundationModels

@Generable
enum Currency: String, Codable, CaseIterable {

    case eur = "EUR"

    case usd = "USD"
}
