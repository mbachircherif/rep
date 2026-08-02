//
//  Discount.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 02/08/2026.
//

import Foundation

protocol Discount {

    var name:  String    { get set }

    var type:  ValueType { get set }

    var value: Decimal   { get set }
}

