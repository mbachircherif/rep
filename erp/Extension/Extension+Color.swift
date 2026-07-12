//
//  Extension+Color.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 11/07/2026.
//

import SwiftUI

extension Color {

    /// Creates a `Color` from a hexadecimal string.
    ///
    /// Supports the following formats (with or without a leading `#`):
    /// - `RGB` (12-bit)
    /// - `RRGGBB` (24-bit)
    /// - `AARRGGBB` (32-bit with alpha)
    ///
    /// Returns `nil` if the string is not a valid hex color.
    init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        guard let value = UInt64(hexString, radix: 16) else { return nil }

        let red, green, blue, alpha: Double
        switch hexString.count {
        case 3: // RGB (12-bit)
            red = Double((value >> 8) & 0xF) / 15
            green = Double((value >> 4) & 0xF) / 15
            blue = Double(value & 0xF) / 15
            alpha = 1
        case 6: // RRGGBB (24-bit)
            red = Double((value >> 16) & 0xFF) / 255
            green = Double((value >> 8) & 0xFF) / 255
            blue = Double(value & 0xFF) / 255
            alpha = 1
        case 8: // AARRGGBB (32-bit)
            alpha = Double((value >> 24) & 0xFF) / 255
            red = Double((value >> 16) & 0xFF) / 255
            green = Double((value >> 8) & 0xFF) / 255
            blue = Double(value & 0xFF) / 255
        default:
            return nil
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    /// The hexadecimal string representation of the color.
    ///
    /// - Parameter includeAlpha: When `true`, the returned string is prefixed with the
    ///   alpha component (`#AARRGGBB`). Otherwise it is `#RRGGBB`.
    /// - Returns: A `#`-prefixed uppercase hex string, or `nil` if the color's
    ///   components cannot be resolved.
    func toHex(includeAlpha: Bool = false) -> String? {
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        #if canImport(AppKit)
        guard let color = NativeColor(self).usingColorSpace(.sRGB) else { return nil }
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #else
        guard NativeColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        #endif

        let r = Int(round(red * 255))
        let g = Int(round(green * 255))
        let b = Int(round(blue * 255))
        let a = Int(round(alpha * 255))

        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X", a, r, g, b)
        } else {
            return String(format: "#%02X%02X%02X", r, g, b)
        }
    }
}
