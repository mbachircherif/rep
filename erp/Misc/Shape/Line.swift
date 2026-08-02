//
//  Line.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 02/08/2026.
//

import SwiftUI

struct Line: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: rect.origin)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.origin.y))

        return path
    }
}
