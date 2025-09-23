//
//  HomeScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct HomeScreen: View {
    let onCardTap: (CardItem) -> Void
    let onRefresh: () -> Void

    @State private var selectedCard: CardItem?
    @State private var showCardDetail = false

    public var body: some View {
        NavigationStack {
            MainScreen(
                onCardTap: { card in
                    selectedCard = card
                    showCardDetail = true
                },
                onRefresh: onRefresh
            )
            .navigationDestination(isPresented: $showCardDetail) {
                if let card = selectedCard {
                    CardDetailView(card: card)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeScreen(
        onCardTap: { card in
            print("Card tapped: \(card.title)")
        },
        onRefresh: {
            print("Refresh triggered")
        }
    )
}
