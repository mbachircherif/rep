//
//  Field.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

struct Field<Key, Value> where Key : Hashable {

    var key: Key

    var value: Value

    var state: State

    init(key: Key, value: Value) {
        self.key   = key
        self.value = value
        self.state = .idle
    }
}

extension Field {

    enum State {

        case idle

        case valid

        case error(reason: String)

        var isValid: Bool {
            if case .valid = self { true } else { false }
        }

        var isError: Bool {
            if case .error = self { true } else { false }
        }
    }
}
