//
//  LabelRow.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 23/09/2025.
//

import SwiftUI

// MARK: - Label Row Component
public struct LabelRow: View {
    private let text: String
    private let icon: String
    private let iconColor: Color
    private let textColor: Color
    private let font: Font
    private let spacing: CGFloat
    private let alignment: VerticalAlignment

    public init(
        text: String,
        icon: String,
        iconColor: Color = ColorPalette.accent,
        textColor: Color = ColorPalette.textSecondary,
        font: Font = FontStyles.caption,
        spacing: CGFloat = Spacing.xs,
        alignment: VerticalAlignment = .center
    ) {
        self.text = text
        self.icon = icon
        self.iconColor = iconColor
        self.textColor = textColor
        self.font = font
        self.spacing = spacing
        self.alignment = alignment
    }

    public var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(iconColor)
                .frame(width: 16, height: 16)

            Text(text)
                .font(font)
                .foregroundColor(textColor)
                .lineLimit(1)
        }
    }
}

// MARK: - Label Row with Custom Content
public struct LabelRowContent<Content: View>: View {
    private let icon: String
    private let iconColor: Color
    private let spacing: CGFloat
    private let content: Content

    public init(
        icon: String,
        iconColor: Color = ColorPalette.accent,
        spacing: CGFloat = Spacing.xs,
        @ViewBuilder content: () -> Content
    ) {
        self.icon = icon
        self.iconColor = iconColor
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(iconColor)
                .frame(width: 16, height: 16)

            content
        }
    }
}

// MARK: - Label Grid
public struct LabelGrid: View {
    private let labels: [LabelItem]
    private let columns: Int
    private let spacing: CGFloat
    private let iconColor: Color
    private let textColor: Color
    private let font: Font

    public init(
        labels: [LabelItem],
        columns: Int = 2,
        spacing: CGFloat = Spacing.s,
        iconColor: Color = ColorPalette.accent,
        textColor: Color = ColorPalette.textSecondary,
        font: Font = FontStyles.caption
    ) {
        self.labels = labels
        self.columns = columns
        self.spacing = spacing
        self.iconColor = iconColor
        self.textColor = textColor
        self.font = font
    }

    public var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns),
            spacing: spacing
        ) {
            ForEach(labels) { label in
                LabelRow(
                    text: label.text,
                    icon: label.icon,
                    iconColor: iconColor,
                    textColor: textColor,
                    font: font
                )
            }
        }
    }
}

// MARK: - Convenience Initializers
public extension LabelRow {
    init(_ label: LabelItem, iconColor: Color = ColorPalette.accent) {
        self.init(
            text: label.text,
            icon: label.icon,
            iconColor: iconColor
        )
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: Spacing.l) {
        // Single label row
        LabelRow(
            text: "iOS Development",
            icon: "swift",
            iconColor: ColorPalette.accent,
            textColor: ColorPalette.textSecondary
        )

        // Label with custom content
        LabelRowContent(
            icon: "star.fill",
            iconColor: ColorPalette.warning
        ) {
            Text("Premium Feature")
                .font(FontStyles.caption)
                .foregroundColor(ColorPalette.textPrimary)
        }

        // Label grid
        LabelGrid(
            labels: [
                LabelItem(text: "Design", icon: "paintbrush.fill"),
                LabelItem(text: "Development", icon: "hammer.fill"),
                LabelItem(text: "Testing", icon: "checkmark.circle.fill"),
                LabelItem(text: "Security", icon: "lock.shield.fill")
            ],
            columns: 2,
            iconColor: ColorPalette.accent
        )
    }
    .padding(Spacing.screenPadding)
}
