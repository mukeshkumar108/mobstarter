//
//  CardListView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 23/09/2025.
//

import SwiftUI

// MARK: - Card List View
public struct CardListView: View {
    private let cards: [CardItem]
    private let onCardTap: (CardItem) -> Void
    private let onRefresh: (() -> Void)?

    @State private var isLoading = false
    @State private var errorMessage: String?

    public init(
        cards: [CardItem]? = nil,
        onCardTap: @escaping (CardItem) -> Void,
        onRefresh: (() -> Void)? = nil
    ) {
        self.cards = cards ?? DataLoader.loadCards()
        self.onCardTap = onCardTap
        self.onRefresh = onRefresh
    }

    public var body: some View {
        Group {
            if isLoading {
                // Loading State
                VStack(spacing: Spacing.l) {
                    Spacer()
                    LoaderView()
                    Text("Loading cards...")
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textSecondary)
                    Spacer()
                }
            } else if let errorMessage = errorMessage {
                // Error State
                VStack(spacing: Spacing.l) {
                    Spacer()
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48, weight: .regular))
                        .foregroundColor(ColorPalette.error)

                    Text("Unable to load cards")
                        .font(FontStyles.heading2)
                        .foregroundColor(ColorPalette.textPrimary)

                    Text(errorMessage)
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textSecondary)
                        .multilineTextAlignment(.center)

                    if onRefresh != nil {
                        PrimaryButton("Try Again", action: {
                            refreshCards()
                        })
                    }

                    Spacer()
                }
                .padding(Spacing.screenPadding)
            } else {
                // Cards List
                LazyVStack(spacing: Spacing.m) {
                    ForEach(cards) { card in
                        CardView(
                            padding: .large,
                            onTap: {
                                onCardTap(card)
                            }
                        ) {
                            CardRowContent(card: card)
                        }
                        .matchedGeometryEffect(id: card.id, in: Self.cardAnimation)
                    }
                }
            }
        }
        .refreshable {
            await refreshCardsAsync()
        }
    }

    // MARK: - Animation Namespace
    @Namespace static var cardAnimation

    // MARK: - Card Row Content
    private struct CardRowContent: View {
        let card: CardItem

        var body: some View {
            VStack(alignment: .leading, spacing: Spacing.s) {
                // Card Header
                HStack(alignment: .top, spacing: Spacing.m) {
                    Image(systemName: card.icon)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(ColorPalette.accent)
                        .frame(width: 32, height: 32)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(card.title)
                            .font(FontStyles.heading3)
                            .foregroundColor(ColorPalette.textPrimary)
                            .lineLimit(1)

                        Text(card.subtitle)
                            .font(FontStyles.caption)
                            .foregroundColor(ColorPalette.textSecondary)
                            .lineLimit(1)
                    }

                    Spacer()

                    // Badge
                    if let badge = card.badge {
                        Text(badge)
                            .font(FontStyles.caption)
                            .foregroundColor(ColorPalette.white)
                            .padding(.horizontal, Spacing.xs)
                            .padding(.vertical, 2)
                            .background(ColorPalette.accent)
                            .cornerRadius(CornerRadius.xs)
                    }

                    Image(systemName: "chevron.right")
                        .foregroundColor(ColorPalette.gray400)
                        .font(.system(size: 12, weight: .semibold))
                }

                // Card Description
                Text(card.description)
                    .font(FontStyles.body)
                    .foregroundColor(ColorPalette.textSecondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                // Labels Preview (if any)
                if let labels = card.labels, !labels.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: Spacing.s) {
                            ForEach(labels.prefix(3)) { label in
                                LabelRow(
                                    text: label.text,
                                    icon: label.icon,
                                    iconColor: ColorPalette.gray400,
                                    textColor: ColorPalette.textTertiary,
                                    font: FontStyles.caption2,
                                    spacing: 4
                                )
                            }

                            if labels.count > 3 {
                                Text("+\(labels.count - 3) more")
                                    .font(FontStyles.caption2)
                                    .foregroundColor(ColorPalette.textTertiary)
                            }
                        }
                    }
                }

                // Card Footer
                HStack {
                    Text(card.timestamp)
                        .font(FontStyles.caption)
                        .foregroundColor(ColorPalette.textTertiary)

                    Spacer()
                }
            }
        }
    }

    // MARK: - Refresh Methods
    private func refreshCards() {
        Task {
            await refreshCardsAsync()
        }
    }

    private func refreshCardsAsync() async {
        isLoading = true
        errorMessage = nil

        // Simulate network delay
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds

        // Reload cards
        onRefresh?()
        isLoading = false
    }
}

// MARK: - Convenience Initializers
public extension CardListView {
    init(onCardTap: @escaping (CardItem) -> Void) {
        self.init(cards: nil, onCardTap: onCardTap, onRefresh: nil)
    }

    init(
        cards: [CardItem],
        onCardTap: @escaping (CardItem) -> Void
    ) {
        self.init(cards: cards, onCardTap: onCardTap, onRefresh: nil)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        CardListView(
            cards: CardItem.previewCards,
            onCardTap: { card in
                print("Card tapped: \(card.title)")
            }
        )
    }
    .padding(Spacing.screenPadding)
}
