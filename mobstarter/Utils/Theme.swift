//
//  Theme.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

// MARK: - Color Palette
public struct ColorPalette {
    // Base Colors
    public static let offBlack = Color(hex: "#111111")
    public static let white = Color.white
    public static let black = Color.black

    // Neutral Grays
    public static let gray50 = Color(hex: "#F9FAFB")
    public static let gray100 = Color(hex: "#F3F4F6")
    public static let gray200 = Color(hex: "#E5E7EB")
    public static let gray300 = Color(hex: "#D1D5DB")
    public static let gray400 = Color(hex: "#9CA3AF")
    public static let gray500 = Color(hex: "#6B7280")
    public static let gray600 = Color(hex: "#4B5563")
    public static let gray700 = Color(hex: "#374151")
    public static let gray800 = Color(hex: "#1F2937")
    public static let gray900 = Color(hex: "#111827")

    // Semantic Colors
    public static let accent = ColorPalette.offBlack  // Off-black for premium feel
    public static let accentLight = ColorPalette.gray200  // Subtle highlight variant
    public static let success = Color(hex: "#22C55E").opacity(0.8)  // Muted green
    public static let error = Color(hex: "#EF4444").opacity(0.8)    // Muted red
    public static let warning = Color(hex: "#F59E0B").opacity(0.8)  // Muted orange
    public static let linkColor = ColorPalette.gray600  // Sophisticated gray

    // Background Colors
    public static let background = ColorPalette.white
    public static let surface = ColorPalette.gray50
    public static let card = ColorPalette.white

    // Dark Mode Variants
    public static let backgroundDark = Color(hex: "#111111")
    public static let surfaceDark = Color(hex: "#1C1C1E")
    public static let textPrimaryDark = Color.white
    public static let textSecondaryDark = Color(hex: "#9CA3AF")

    // Text Colors
    public static let textPrimary = ColorPalette.offBlack
    public static let textSecondary = ColorPalette.gray600
    public static let textTertiary = ColorPalette.gray400
}

// MARK: - Font Styles
public struct FontStyles {
    // Headings
    public static let heading1 = Font.system(.title, design: .default).weight(.bold)
    public static let heading2 = Font.system(.title2, design: .default).weight(.semibold)
    public static let heading3 = Font.system(.title3, design: .default).weight(.semibold)

    // Body Text
    public static let bodyLarge = Font.system(.body, design: .default).weight(.regular)
    public static let body = Font.system(.body, design: .default).weight(.regular)
    public static let bodySmall = Font.system(.callout, design: .default).weight(.regular)

    // UI Elements
    public static let button = Font.system(.headline, design: .default).weight(.semibold)
    public static let caption = Font.system(.caption, design: .default).weight(.regular)
    public static let caption2 = Font.system(.caption2, design: .default).weight(.regular)
}

// MARK: - Spacing
public struct Spacing {
    public static let xs: CGFloat = 4
    public static let s: CGFloat = 8
    public static let m: CGFloat = 16
    public static let l: CGFloat = 24
    public static let xl: CGFloat = 32
    public static let xxl: CGFloat = 48

    // Common spacing patterns
    public static let cardPadding = Spacing.m
    public static let screenPadding = Spacing.l
    public static let componentSpacing = Spacing.s
}

// MARK: - Corner Radius
public struct CornerRadius {
    public static let none: CGFloat = 0
    public static let xs: CGFloat = 4
    public static let s: CGFloat = 8
    public static let `default`: CGFloat = 12
    public static let l: CGFloat = 16
    public static let xl: CGFloat = 24
    public static let roundedXL: CGFloat = 32
    public static let full: CGFloat = 999
}

// MARK: - Shadows
public struct Shadows {
    public static let card = Shadow(
        color: ColorPalette.offBlack.opacity(0.06),  // Softer, more spread
        radius: 16,  // Larger radius
        x: 0,
        y: 4
    )

    public static let button = Shadow(
        color: ColorPalette.offBlack.opacity(0.08),
        radius: 6,
        x: 0,
        y: 2
    )

    public static let modal = Shadow(
        color: ColorPalette.offBlack.opacity(0.15),
        radius: 24,  // Softer, blurrier
        x: 0,
        y: 8
    )
}

// MARK: - Shadow Model
public struct Shadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    public func apply(to view: AnyView) -> AnyView {
        AnyView(view.shadow(color: color, radius: radius, x: x, y: y))
    }
}

// MARK: - Color Hex Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Theme Preview
#Preview("Light Mode") {
    VStack(spacing: Spacing.m) {
        Text("Design System Preview")
            .font(FontStyles.heading1)
            .foregroundColor(ColorPalette.textPrimary)

        HStack(spacing: Spacing.s) {
            Circle().fill(ColorPalette.accent).frame(width: 20, height: 20)
            Circle().fill(ColorPalette.success).frame(width: 20, height: 20)
            Circle().fill(ColorPalette.error).frame(width: 20, height: 20)
            Circle().fill(ColorPalette.warning).frame(width: 20, height: 20)
            Circle().fill(ColorPalette.linkColor).frame(width: 20, height: 20)
        }

        Text("Body text example")
            .font(FontStyles.body)
            .foregroundColor(ColorPalette.textSecondary)

        Text("Caption text")
            .font(FontStyles.caption)
            .foregroundColor(ColorPalette.textTertiary)
    }
    .padding(Spacing.screenPadding)
    .background(ColorPalette.background)
}

#Preview("Dark Mode") {
    VStack(spacing: Spacing.m) {
        Text("Design System Preview")
            .font(FontStyles.heading1)
            .foregroundColor(ColorPalette.textPrimaryDark)

        HStack(spacing: Spacing.s) {
            Circle().fill(ColorPalette.accent).frame(width: 20, height: 20)
            Circle().fill(ColorPalette.success).frame(width: 20, height: 20)
            Circle().fill(ColorPalette.error).frame(width: 20, height: 20)
            Circle().fill(ColorPalette.warning).frame(width: 20, height: 20)
            Circle().fill(ColorPalette.linkColor).frame(width: 20, height: 20)
        }

        Text("Body text example")
            .font(FontStyles.body)
            .foregroundColor(ColorPalette.textSecondaryDark)

        Text("Caption text")
            .font(FontStyles.caption)
            .foregroundColor(ColorPalette.textSecondaryDark)
    }
    .padding(Spacing.screenPadding)
    .background(ColorPalette.backgroundDark)
    .preferredColorScheme(.dark)
}
