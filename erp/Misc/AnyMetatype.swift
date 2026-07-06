//
//  AnyMetatype.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 06/07/2026.
//

public struct AnyMetatype {

    let metatype: Any.Type

    init<T>(_ metatype: T) {
        self.metatype = T.self
    }
}

extension AnyMetatype: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.metatype == rhs.metatype
    }
}

extension AnyMetatype: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(metatype))
    }
}
