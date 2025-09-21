//
//  AboutScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct AboutScreen: View {
    public var body: some View {
        VStack(spacing: Spacing.l) {
            Text("About")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            VStack(spacing: Spacing.m) {
                TextKeyValueView(key: "App Name", value: "MobStarter")
                TextKeyValueView(key: "Version", value: "1.0.0")
                TextKeyValueView(key: "Developer", value: "Your Company")
                TextKeyValueView(key: "Built with", value: "SwiftUI")
            }

            Spacer()
        }
        .padding(Spacing.screenPadding)
        .background(ColorPalette.surface)
    }
}

// MARK: - Preview
#Preview {
    AboutScreen()
}
