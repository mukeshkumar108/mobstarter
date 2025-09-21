//
//  SearchScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct SearchScreen: View {
    public var body: some View {
        VStack(spacing: Spacing.l) {
            Header(title: "Search", subtitle: "Find what you're looking for")

            Text("Search functionality coming soon...")
                .font(FontStyles.body)
                .foregroundColor(ColorPalette.textSecondary)

            Spacer()
        }
        .padding(Spacing.screenPadding)
        .background(ColorPalette.surface)
    }
}

// MARK: - Preview
#Preview {
    SearchScreen()
}
