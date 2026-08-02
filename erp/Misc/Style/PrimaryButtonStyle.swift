//
//  PrimaryButtonStyle.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 02/08/2026.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 18.0, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#3b82f6")!, in: .capsule)
            .overlay(
                LinearGradient(
                    colors: [
                        Color(hex: "#60a5fa")!,
                        Color(hex: "#2563eb")!,
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ),
                in: .capsule.stroke(lineWidth: 2.5)
            )
    }
}
