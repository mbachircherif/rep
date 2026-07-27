//
//  Field.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 23/07/2026.
//

struct Field<T> {

    var value: T

    var state: State

    init(value: T) {
        self.value = value
        self.state = .idle
    }
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
