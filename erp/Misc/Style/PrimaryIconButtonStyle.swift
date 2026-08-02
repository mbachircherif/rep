//
//  PrimaryIconButtonStyle.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 03/08/2026.
//

import SwiftUI

struct PrimaryIconButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 16.0, weight: .semibold, design: .rounded))
            .foregroundStyle(Color(hex: "#38bdf8")!)
            .padding(8.0)
            .background(Color(hex: "#f0f9ff")!, in: .circle)
    }
}

