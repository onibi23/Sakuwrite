//
//  ColorExtension.swift
//  Mostro
//
//  Created by Paola Barbuto Ferraiuolo on 11/12/24.
//


// Color+Extensions.swift
import SwiftUI

public extension Color {
    init(hex: String) {
        var hexSanitized = hex.replacingOccurrences(of: "#", with: "")
        assert(hexSanitized.count == 6 || hexSanitized.count == 8, "Hex code must be 6 or 8 characters long.")

        if hexSanitized.count == 6 {
            hexSanitized += "FF"
        }

        let scanner = Scanner(string: hexSanitized)
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)

        let r = Double((hexNumber & 0xFF000000) >> 24) / 255.0
        let g = Double((hexNumber & 0x00FF0000) >> 16) / 255.0
        let b = Double((hexNumber & 0x0000FF00) >> 8) / 255.0
        let a = Double(hexNumber & 0x000000FF) / 255.0

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
