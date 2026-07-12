//
//  IndexedElement.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 12/07/2026.
//

struct IndexedElement<T> {

    let index: Int

    let value: T
}

extension IndexedElement: Equatable where T : Equatable {}

extension IndexedElement: Hashable where T: Hashable {}
