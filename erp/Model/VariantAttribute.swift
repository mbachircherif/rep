//
//  VariantAttribute.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 08/07/2026.
//

import Foundation

protocol VariantAttribute {

    var kind: AttributeKind { get set }

    var key: String { get set }

    var value: String { get set }
}
