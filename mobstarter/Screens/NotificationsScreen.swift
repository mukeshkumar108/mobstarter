//
//  NotificationsScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct NotificationsScreen: View {
    public var body: some View {
        VStack(spacing: Spacing.l) {
            Header(title: "Notifications", subtitle: "Stay updated")

            Text("Notifications coming soon...")
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
    NotificationsScreen()
}
