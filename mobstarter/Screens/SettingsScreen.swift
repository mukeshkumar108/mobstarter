//
//  SettingsScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct SettingsScreen: View {
    public var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Settings")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            VStack(spacing: Spacing.m) {
                TextKeyValueView(key: "Version", value: "1.0.0")
                TextKeyValueView(key: "Build", value: "1")
                TextKeyValueView(key: "Theme", value: "System")
            }

            Spacer()
        }
        .padding(Spacing.screenPadding)
        .background(ColorPalette.surface)
    }
}

// MARK: - Preview
#Preview {
    SettingsScreen()
}
