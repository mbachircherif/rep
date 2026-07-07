//
//  Mouvement.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 07/07/2026.
//

import Foundation
import SwiftData

@Model
final class Mouvement {

    var id: UUID

    var product: Product?

    init(id: UUID, product: Product) {
        self.id = id
        self.product = product
    }
}
