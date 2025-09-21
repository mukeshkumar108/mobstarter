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

    public var body: some View {
        MainScreen(
            onCardTap: onCardTap,
            onRefresh: onRefresh
        )
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
