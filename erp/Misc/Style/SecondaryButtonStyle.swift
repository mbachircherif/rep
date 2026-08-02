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
            .padding(EdgeInsets(top: 10.0, leading: 18.0, bottom: 10.0, trailing: 18.0))
            .background(Color(hex: "#3b82f6")!, in: .capsule.stroke())
    }
}
