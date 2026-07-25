//
//  Field.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

struct Field<T> {

    var value: T

    var state: State
}

extension Field {

    enum State {

        case idle

        case valid

        case error(reason: String)

        var isError: Bool {
            if case .error = self { true } else { false }
        }
    }
}
