//
//  FieldError.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 24/07/2026.
//

struct FieldError<Field>: Error where Field : Hashable, Field : Sendable {

    // TODO: Improve.
    let field: Field

    let reason: String
}
