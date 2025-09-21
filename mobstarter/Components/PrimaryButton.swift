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

    public init(
        _ title: String,
        icon: Image? = nil,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isLoading = isLoading
        self.isDisabled = isDisabled
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
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.m)
            .padding(.horizontal, Spacing.l)
            .background(
                isDisabled ?
                ColorPalette.gray300 :
                ColorPalette.accent
            )
            .foregroundColor(ColorPalette.white)
            .cornerRadius(CornerRadius.default)
            .shadow(color: Shadows.button.color, radius: Shadows.button.radius, x: Shadows.button.x, y: Shadows.button.y)
        }
        .disabled(isDisabled || isLoading)
        .opacity(isDisabled && !isLoading ? 0.6 : 1.0)
    }
}

// MARK: - Convenience Initializers
public extension PrimaryButton {
    init(_ title: String, action: @escaping () -> Void) {
        self.init(title, icon: nil, isLoading: false, isDisabled: false, action: action)
    }

    init(_ title: String, isLoading: Bool, action: @escaping () -> Void) {
        self.init(title, icon: nil, isLoading: isLoading, isDisabled: false, action: action)
    }

    init(_ title: String, isDisabled: Bool, action: @escaping () -> Void) {
        self.init(title, icon: nil, isLoading: false, isDisabled: isDisabled, action: action)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: Spacing.m) {
        PrimaryButton("Get Started", action: {})
        PrimaryButton("Loading", isLoading: true, action: {})
        PrimaryButton("Disabled", isDisabled: true, action: {})
        PrimaryButton("With Icon", icon: Image(systemName: "star.fill"), action: {})
    }
    .padding(Spacing.screenPadding)
}
