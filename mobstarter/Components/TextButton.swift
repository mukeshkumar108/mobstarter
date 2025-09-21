//
//  TextButton.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct TextButton: View {
    private let title: String
    private let action: () -> Void
    private let style: TextButtonStyle
    private let icon: Image?
    private let isDisabled: Bool

    public init(
        _ title: String,
        style: TextButtonStyle = .primary,
        icon: Image? = nil,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.icon = icon
        self.isDisabled = isDisabled
        self.action = action
    }

    public var body: some View {
        Button(action: {
            guard !isDisabled else { return }
            action()
        }) {
            HStack(spacing: Spacing.xs) {
                if let icon = icon {
                    icon
                        .imageScale(.small)
                        .frame(width: 14, height: 14)
                }

                Text(title)
                    .font(FontStyles.button)
                    .lineLimit(1)
            }
            .padding(.vertical, Spacing.s)
            .padding(.horizontal, Spacing.m)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(CornerRadius.s)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.s)
                    .stroke(borderColor, lineWidth: style.hasBorder ? 1 : 0)
            )
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.6 : 1.0)
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return isDisabled ? ColorPalette.gray400 : ColorPalette.accent
        case .secondary:
            return isDisabled ? ColorPalette.gray400 : ColorPalette.textSecondary
        case .danger:
            return isDisabled ? ColorPalette.gray400 : ColorPalette.error
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary, .secondary:
            return Color.clear
        case .danger:
            return ColorPalette.error.opacity(0.1)
        }
    }

    private var borderColor: Color {
        switch style {
        case .primary:
            return ColorPalette.accent
        case .secondary:
            return ColorPalette.gray300
        case .danger:
            return ColorPalette.error
        }
    }
}

// MARK: - Text Button Styles
public enum TextButtonStyle {
    case primary      // Accent color, no background
    case secondary    // Gray color, subtle border
    case danger       // Red color, light red background

    var hasBorder: Bool {
        switch self {
        case .primary, .danger:
            return false
        case .secondary:
            return true
        }
    }
}

// MARK: - Convenience Initializers
public extension TextButton {
    init(_ title: String, action: @escaping () -> Void) {
        self.init(title, style: .primary, icon: nil, isDisabled: false, action: action)
    }

    init(_ title: String, style: TextButtonStyle, action: @escaping () -> Void) {
        self.init(title, style: style, icon: nil, isDisabled: false, action: action)
    }

    init(_ title: String, isDisabled: Bool, action: @escaping () -> Void) {
        self.init(title, style: .primary, icon: nil, isDisabled: isDisabled, action: action)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: Spacing.m) {
        TextButton("Primary Button", action: {})
        TextButton("Secondary", style: .secondary, action: {})
        TextButton("Danger", style: .danger, action: {})
        TextButton("With Icon", icon: Image(systemName: "arrow.right"), action: {})
        TextButton("Disabled", isDisabled: true, action: {})
    }
    .padding(Spacing.screenPadding)
}
