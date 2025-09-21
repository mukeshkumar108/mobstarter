//
//  ProfileScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct ProfileScreen: View {
    public var body: some View {
        VStack(spacing: Spacing.l) {
            Header(title: "Profile", subtitle: "Manage your account")

            Text("Profile screen coming soon...")
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
    ProfileScreen()
}
