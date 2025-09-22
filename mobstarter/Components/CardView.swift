//
//  CardView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct CardView<Content: View>: View {
    private let content: Content
    private let padding: CardPadding
    private let cornerRadius: CGFloat
    private let shadow: Shadow?
    private let backgroundColor: Color
    private let borderColor: Color?
    private let withAccentBorder: Bool
    private let withMaterial: Bool
    private let onTap: (() -> Void)?

    public init(
        padding: CardPadding = .medium,
        cornerRadius: CGFloat = CornerRadius.l,
        shadow: Shadow? = Shadows.card,
        backgroundColor: Color = ColorPalette.card,
        borderColor: Color? = nil,
        withAccentBorder: Bool = false,
        withMaterial: Bool = false,
        onTap: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.shadow = shadow
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.withAccentBorder = withAccentBorder
        self.withMaterial = withMaterial
        self.onTap = onTap
    }

    public var body: some View {
        Group {
            if let onTap = onTap {
                Button(action: onTap) {
                    cardContent
                }
                .buttonStyle(CardButtonStyle())
            } else {
                cardContent
            }
        }
    }

    private var cardContent: some View {
        content
            .padding(padding.value)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(withMaterial ? AnyView(Color.clear) : AnyView(backgroundColor))
            .cornerRadius(cornerRadius)
            .ifLet(shadow) { view, shadow in
                view.shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
            }
            .ifLet(borderColor) { view, borderColor in
                view.overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 1)
                )
            }
            .if(withAccentBorder) { _ in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [ColorPalette.accent.opacity(0.5), ColorPalette.accent.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
    }
}

// MARK: - Card Padding
public enum CardPadding {
    case none
    case small
    case medium
    case large
    case custom(CGFloat)

    var value: CGFloat {
        switch self {
        case .none:
            return 0
        case .small:
            return Spacing.s
        case .medium:
            return Spacing.m
        case .large:
            return Spacing.l
        case .custom(let value):
            return value
        }
    }
}

// MARK: - Card Button Style
private struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - View Extension for Optional Binding
extension View {
    @ViewBuilder
    func ifLet<V, Content: View>(
        _ value: V?,
        transform: (Self, V) -> Content
    ) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }

    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Convenience Initializers
public extension CardView {
    init(
        @ViewBuilder content: () -> Content
    ) {
        self.init(padding: .medium, content: content)
    }

    init(
        padding: CardPadding = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.init(padding: padding, content: content)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: Spacing.l) {
        CardView {
            VStack(alignment: .leading, spacing: Spacing.s) {
                Text("Card Title")
                    .font(FontStyles.heading3)
                    .foregroundColor(ColorPalette.textPrimary)

                Text("This is a description of the card content. It can contain multiple lines of text.")
                    .font(FontStyles.body)
                    .foregroundColor(ColorPalette.textSecondary)
                    .lineLimit(3)

                TextButton("Action", action: {})
            }
        }

        CardView(padding: .large, shadow: nil, backgroundColor: ColorPalette.surface) {
            HStack(spacing: Spacing.m) {
                Image(systemName: "star.fill")
                    .foregroundColor(ColorPalette.accent)
                    .font(.title2)

                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Compact Card")
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textPrimary)

                    Text("Small description")
                        .font(FontStyles.caption)
                        .foregroundColor(ColorPalette.textSecondary)
                }
            }
        }

        CardView(
            padding: .small,
            borderColor: ColorPalette.accent,
            onTap: { print("Card tapped!") }
        ) {
            Text("Tap me!")
                .font(FontStyles.body)
                .foregroundColor(ColorPalette.accent)
                .frame(maxWidth: .infinity, alignment: .center)
        }

        CardView(
            padding: .medium,
            withAccentBorder: true,
            onTap: { print("Gradient border card tapped!") }
        ) {
            VStack(alignment: .leading, spacing: Spacing.s) {
                Text("Premium Card")
                    .font(FontStyles.heading3)
                    .foregroundColor(ColorPalette.textPrimary)

                Text("This card has a gradient border for a premium look.")
                    .font(FontStyles.body)
                    .foregroundColor(ColorPalette.textSecondary)
                    .lineLimit(2)
            }
        }

        CardView(
            padding: .medium,
            withMaterial: true,
            onTap: { print("Material card tapped!") }
        ) {
            VStack(alignment: .leading, spacing: Spacing.s) {
                Text("iOS Blur Card")
                    .font(FontStyles.heading3)
                    .foregroundColor(ColorPalette.textPrimary)

                Text("This card uses .ultraThinMaterial for native iOS blur effect.")
                    .font(FontStyles.body)
                    .foregroundColor(ColorPalette.textSecondary)
                    .lineLimit(2)
            }
        }
    }
    .padding(Spacing.screenPadding)
}
