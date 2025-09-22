//
//  PrimaryButton.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct PrimaryButton: View {
    private let title: String
    private let action: () -> Void
    private let isLoading: Bool
    private let isDisabled: Bool
    private let icon: Image?
    private let fullWidth: Bool
    private let style: PrimaryButtonStyle

    public init(
        _ title: String,
        style: PrimaryButtonStyle = .filled,
        icon: Image? = nil,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        fullWidth: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.icon = icon
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.fullWidth = fullWidth
        self.action = action
    }

    public var body: some View {
        Button(action: {
            guard !isLoading && !isDisabled else { return }
            action()
        }) {
            HStack(spacing: Spacing.s) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: ColorPalette.white))
                        .frame(width: 16, height: 16)
                } else if let icon = icon {
                    icon
                        .imageScale(.medium)
                        .frame(width: 16, height: 16)
                }

                Text(title)
                    .font(FontStyles.button)
                    .lineLimit(1)
            }
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .padding(.vertical, Spacing.m)
            .padding(.horizontal, fullWidth ? Spacing.xl : Spacing.l)
            .background(
                isDisabled ?
                ColorPalette.gray300 :
                (style == .filled ? ColorPalette.accent : ColorPalette.white)
            )
            .foregroundColor(
                isDisabled ?
                ColorPalette.gray400 :
                (style == .filled ? ColorPalette.white : ColorPalette.accent)
            )
            .cornerRadius(fullWidth ? CornerRadius.roundedXL : CornerRadius.l)
            .if(style == .inverted) { view in
                view.overlay(
                    RoundedRectangle(cornerRadius: fullWidth ? CornerRadius.roundedXL : CornerRadius.l)
                        .stroke(ColorPalette.gray300, lineWidth: 1)
                )
            }
            .shadow(color: Shadows.button.color, radius: Shadows.button.radius, x: Shadows.button.x, y: Shadows.button.y)
        }
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .opacity(isPressed ? 0.9 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .disabled(isDisabled || isLoading)
        .opacity(isDisabled && !isLoading ? 0.6 : 1.0)
    }

    @State private var isPressed = false
}

// MARK: - Button Styles
public enum PrimaryButtonStyle {
    case filled    // offBlack background, white text
    case inverted  // white background, offBlack text, subtle border
}

// MARK: - Convenience Initializers
public extension PrimaryButton {
    init(_ title: String, action: @escaping () -> Void) {
        self.init(title, style: .filled, icon: nil, isLoading: false, isDisabled: false, fullWidth: false, action: action)
    }

    init(_ title: String, isLoading: Bool, action: @escaping () -> Void) {
        self.init(title, style: .filled, icon: nil, isLoading: isLoading, isDisabled: false, fullWidth: false, action: action)
    }

    init(_ title: String, isDisabled: Bool, action: @escaping () -> Void) {
        self.init(title, style: .filled, icon: nil, isLoading: false, isDisabled: isDisabled, fullWidth: false, action: action)
    }

    init(_ title: String, fullWidth: Bool, action: @escaping () -> Void) {
        self.init(title, style: .filled, icon: nil, isLoading: false, isDisabled: false, fullWidth: fullWidth, action: action)
    }

    init(_ title: String, style: PrimaryButtonStyle, action: @escaping () -> Void) {
        self.init(title, style: style, icon: nil, isLoading: false, isDisabled: false, fullWidth: false, action: action)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: Spacing.m) {
        PrimaryButton("Get Started", action: {})
        PrimaryButton("Full Width", fullWidth: true, action: {})
        PrimaryButton("Inverted", style: .inverted, action: {})
        PrimaryButton("Loading", isLoading: true, action: {})
        PrimaryButton("Disabled", isDisabled: true, action: {})
        PrimaryButton("With Icon", icon: Image(systemName: "star.fill"), action: {})
    }
    .padding(Spacing.screenPadding)
}
