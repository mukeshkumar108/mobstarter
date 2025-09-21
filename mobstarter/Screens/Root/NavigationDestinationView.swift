//
//  NavigationDestinationView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

/// Handles navigation destinations for sidebar menu items
public struct NavigationDestinationView: View {
    let screen: NavigationScreen

    public var body: some View {
        ScrollView {
            VStack(spacing: Spacing.l) {
                Header(title: screenTitle, subtitle: screenSubtitle)

                switch screen {
                case .settings:
                    SettingsScreen()
                case .help:
                    HelpScreen()
                case .privacy:
                    PrivacyPolicyScreen()
                case .terms:
                    TermsOfServiceScreen()
                case .about:
                    AboutScreen()
                default:
                    Text("Screen not implemented yet")
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textSecondary)
                }
            }
            .padding(Spacing.screenPadding)
        }
        .background(ColorPalette.surface)
    }

    private var screenTitle: String {
        switch screen {
        case .settings:
            return "Settings"
        case .help:
            return "Help & Support"
        case .privacy:
            return "Privacy Policy"
        case .terms:
            return "Terms of Service"
        case .about:
            return "About"
        default:
            return "Screen"
        }
    }

    private var screenSubtitle: String {
        switch screen {
        case .settings:
            return "Manage your account settings"
        case .help:
            return "Get help and support"
        case .privacy:
            return "Read our privacy policy"
        case .terms:
            return "Read our terms of service"
        case .about:
            return "Learn more about the app"
        default:
            return ""
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationDestinationView(screen: .settings)
}
