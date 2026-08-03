//
//  PrimaryButtonStyle.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 02/08/2026.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 16.0, weight: .semibold, design: .rounded))
            .foregroundStyle(Color(hex: "#3b82f6")!)
            .padding(EdgeInsets(top: 8.0, leading: 14.0, bottom: 8.0, trailing: 14.0))
            .background(Color(hex: "#eff6ff")!, in: .capsule)
    }
}
