//
//  CardDetailView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 23/09/2025.
//

import SwiftUI

// MARK: - Card Detail View
public struct CardDetailView: View {
    let card: CardItem
    @Environment(\.dismiss) private var dismiss

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.xl) {
                // Header Section with Animation
                VStack(alignment: .leading, spacing: Spacing.m) {
                    // Icon and Title
                    HStack(alignment: .top, spacing: Spacing.m) {
                        Image(systemName: card.icon)
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(ColorPalette.accent)
                            .frame(width: 48, height: 48)
                            .background(
                                ColorPalette.accent.opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.l))
                            )

                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            Text(card.title)
                                .font(FontStyles.heading1)
                                .foregroundColor(ColorPalette.textPrimary)
                                .lineLimit(2)

                            Text(card.subtitle)
                                .font(FontStyles.heading3)
                                .foregroundColor(ColorPalette.textSecondary)
                        }

                        Spacer()
                    }

                    // Badge
                    if let badge = card.badge {
                        Text(badge)
                            .font(FontStyles.caption)
                            .foregroundColor(ColorPalette.white)
                            .padding(.horizontal, Spacing.s)
                            .padding(.vertical, Spacing.xs)
                            .background(ColorPalette.accent)
                            .cornerRadius(CornerRadius.s)
                    }
                }
                .padding(Spacing.screenPadding)

                // Description Section
                VStack(alignment: .leading, spacing: Spacing.m) {
                    Text("Description")
                        .font(FontStyles.heading2)
                        .foregroundColor(ColorPalette.textPrimary)

                    Text(card.description)
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textSecondary)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, Spacing.screenPadding)

                // Labels Section
                if let labels = card.labels, !labels.isEmpty {
                    VStack(alignment: .leading, spacing: Spacing.m) {
                        Text("Details")
                            .font(FontStyles.heading2)
                            .foregroundColor(ColorPalette.textPrimary)

                        LabelGrid(
                            labels: labels,
                            columns: 2,
                            spacing: Spacing.s,
                            iconColor: ColorPalette.accent,
                            textColor: ColorPalette.textSecondary
                        )
                    }
                    .padding(.horizontal, Spacing.screenPadding)
                }

                // Footer Section
                VStack(alignment: .leading, spacing: Spacing.s) {
                    Divider()
                        .background(ColorPalette.gray200)

                    HStack {
                        LabelRow(
                            text: card.timestamp,
                            icon: "clock",
                            iconColor: ColorPalette.gray400,
                            textColor: ColorPalette.textTertiary,
                            font: FontStyles.caption
                        )

                        Spacer()

                        TextButton("Close", action: {
                            dismiss()
                        })
                    }
                }
                .padding(Spacing.screenPadding)
            }
        }
        .background(ColorPalette.background)
        .navigationTitle(card.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CardDetailView(
            card: CardItem.previewCards[0]
        )
    }
}
