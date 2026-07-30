//
//  OrderedPick.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 30/07/2026.
//

struct PickerSet<T> where T : Hashable {

    var track: Set<T>

    var items: [IndexedElement<T>]

    func contains(_ item: T) -> Bool {
        track.contains(item)
    }

    mutating func remove(_ item: T) {
        for item in items.enumerated() {

        }
    }
}
