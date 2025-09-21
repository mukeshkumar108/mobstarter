//
//  PrivacyPolicyScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct PrivacyPolicyScreen: View {
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.l) {
                Text("Privacy Policy")
                    .font(FontStyles.heading1)
                    .foregroundColor(ColorPalette.textPrimary)

                Text("Privacy policy content would go here...")
                    .font(FontStyles.body)
                    .foregroundColor(ColorPalette.textSecondary)

                Spacer()
            }
            .padding(Spacing.screenPadding)
        }
        .background(ColorPalette.surface)
    }
}

// MARK: - Preview
#Preview {
    PrivacyPolicyScreen()
}
