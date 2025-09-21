//
//  TextKeyValueView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct TextKeyValueView: View {
    private let key: String
    private let value: String
    private let style: KeyValueStyle
    private let alignment: KeyValueAlignment
    private let showDivider: Bool

    public init(
        key: String,
        value: String,
        style: KeyValueStyle = .standard,
        alignment: KeyValueAlignment = .vertical,
        showDivider: Bool = false
    ) {
        self.key = key
        self.value = value
        self.style = style
        self.alignment = alignment
        self.showDivider = showDivider
    }

    public var body: some View {
        Group {
            if alignment == .horizontal {
                HStack(alignment: .firstTextBaseline, spacing: Spacing.m) {
                    Text(key)
                        .font(keyFont)
                        .foregroundColor(keyColor)
                        .frame(minWidth: 80, alignment: .leading)

                    Text(value)
                        .font(valueFont)
                        .foregroundColor(valueColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
            } else {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(key)
                        .font(keyFont)
                        .foregroundColor(keyColor)

                    Text(value)
                        .font(valueFont)
                        .foregroundColor(valueColor)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .overlay(
            showDivider ?
            Divider()
                .padding(.top, Spacing.s) :
            nil,
            alignment: .bottom
        )
    }

    private var keyFont: Font {
        switch style {
        case .standard:
            return FontStyles.body
        case .compact:
            return FontStyles.bodySmall
        case .prominent:
            return FontStyles.heading3
        }
    }

    private var valueFont: Font {
        switch style {
        case .standard:
            return FontStyles.body
        case .compact:
            return FontStyles.caption
        case .prominent:
            return FontStyles.bodyLarge
        }
    }

    private var keyColor: Color {
        switch style {
        case .standard, .compact:
            return ColorPalette.textSecondary
        case .prominent:
            return ColorPalette.textPrimary
        }
    }

    private var valueColor: Color {
        switch style {
        case .standard, .compact:
            return ColorPalette.textPrimary
        case .prominent:
            return ColorPalette.accent
        }
    }
}

// MARK: - Key Value Styles
public enum KeyValueStyle {
    case standard     // Regular key-value pair
    case compact      // Smaller, more condensed
    case prominent    // Key is prominent, value is highlighted
}

// MARK: - Key Value Alignment
public enum KeyValueAlignment {
    case vertical     // Key on top, value below
    case horizontal   // Key and value side by side
}

// MARK: - Convenience Initializers
public extension TextKeyValueView {
    init(key: String, value: String) {
        self.init(key: key, value: value, style: .standard, alignment: .vertical)
    }

    init(key: String, value: String, style: KeyValueStyle) {
        self.init(key: key, value: value, style: style, alignment: .vertical)
    }

    init(key: String, value: String, alignment: KeyValueAlignment) {
        self.init(key: key, value: value, style: .standard, alignment: alignment)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: Spacing.l) {
        Text("Standard Style")
            .font(FontStyles.heading3)
            .foregroundColor(ColorPalette.textPrimary)

        TextKeyValueView(key: "Name", value: "John Doe")
        TextKeyValueView(key: "Email", value: "john.doe@example.com")
        TextKeyValueView(key: "Phone", value: "+1 (555) 123-4567")

        Divider()

        Text("Compact Style")
            .font(FontStyles.heading3)
            .foregroundColor(ColorPalette.textPrimary)

        TextKeyValueView(key: "Status", value: "Active", style: .compact)
        TextKeyValueView(key: "Last Login", value: "2 hours ago", style: .compact)

        Divider()

        Text("Prominent Style")
            .font(FontStyles.heading3)
            .foregroundColor(ColorPalette.textPrimary)

        TextKeyValueView(key: "Total Balance", value: "$2,547.32", style: .prominent)
        TextKeyValueView(key: "Monthly Goal", value: "$3,000.00", style: .prominent)

        Divider()

        Text("Horizontal Layout")
            .font(FontStyles.heading3)
            .foregroundColor(ColorPalette.textPrimary)

        TextKeyValueView(key: "Username", value: "johndoe123", alignment: .horizontal)
        TextKeyValueView(key: "Member Since", value: "January 2024", alignment: .horizontal)
    }
    .padding(Spacing.screenPadding)
}
