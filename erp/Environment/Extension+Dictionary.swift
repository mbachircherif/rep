//
//  Extension+Dictionary.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 07/07/2026.
//

extension Dictionary {

    subscript(_ key: Key, orCreate newValue: Value) -> Value {
        mutating get {
            if let value = self[key] { return value } else {
                self[key] = newValue
                return newValue
            }
        }
    }
}
