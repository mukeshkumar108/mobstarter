//
//  RootView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct RootView: View {
    @State private var navigationState = NavigationState()
    @State private var appState: AppState = .splash
    @State private var authManager = AuthenticationManager()

    public var body: some View {
        ZStack {
            // Main App Content
            switch appState {
            case .splash:
                SplashScreen(onContinue: {
                    appState = .onboarding
                })

            case .onboarding:
                OnboardingScreen(onComplete: {
                    appState = .auth
                })

            case .auth:
                AuthScreen(
                    authManager: authManager,
                    onLoginSuccess: {
                        appState = .main
                    },
                    onSignUp: {
                        print("Navigate to sign up")
                    },
                    onForgotPassword: {
                        print("Navigate to forgot password")
                    }
                )

            case .main:
                MainAppView(
                    navigationState: navigationState,
                    authManager: authManager,
                    onLogout: {
                        appState = .auth
                    }
                )
            }

            // Global Overlays
            if let activeModal = navigationState.activeModal {
                ModalOverlay(modal: activeModal, navigationState: navigationState)
            }
        }
        .sheet(isPresented: Binding(
            get: { navigationState.activeSheet != nil },
            set: { if !$0 { navigationState.activeSheet = nil } }
        )) {
            if let sheet = navigationState.activeSheet {
                SheetOverlay(sheet: sheet, navigationState: navigationState)
            }
        }
        .onAppear {
            // Check authentication state on app launch
            checkAuthenticationState()
        }
    }

    private func checkAuthenticationState() {
        // If user is already logged in, go directly to main app
        if authManager.isLoggedIn {
            print("🔐 User already logged in, skipping to main app")
            appState = .main
        } else {
            print("🔓 User not logged in, starting with splash screen")
            // Start with splash screen flow for new users
            appState = .splash
        }
    }
}

// MARK: - Main App View
private struct MainAppView: View {
    @Bindable var navigationState: NavigationState
    let authManager: AuthenticationManager
    let onLogout: () -> Void

    var body: some View {
        ZStack {
            // Tab Bar Content
            TabView(selection: $navigationState.selectedTab) {
                ForEach(TabItem.allCases) { tab in
                    TabContentView(tab: tab, navigationState: navigationState)
                        .tabItem {
                            Label(tab.rawValue, systemImage: tab.icon)
                        }
                        .tag(tab)
                }
            }
            .overlay(alignment: .bottom) {
                if !navigationState.tabBarHidden {
                    CustomTabBarWithBadges(
                        selectedTab: $navigationState.selectedTab,
                        badgeCounts: [
                            .notifications: 3,
                            .home: 1
                        ],
                        onTabSelected: { tab in
                            navigationState.selectTab(tab)
                        }
                    )
                }
            }

            // Sidebar
            SidebarView(
                isPresented: $navigationState.sidebarPresented,
                selectedItem: $navigationState.sidebarSelection,
                onItemSelected: { item in
                    navigationState.selectSidebarItem(item)
                    handleSidebarAction(item)
                }
            )
        }
    }

    private func handleSidebarAction(_ item: SidebarItem) {
        switch item {
        case .settings:
            navigationState.navigateTo(.settings)
        case .help:
            navigationState.navigateTo(.help)
        case .privacy:
            navigationState.navigateTo(.privacy)
        case .terms:
            navigationState.navigateTo(.terms)
        case .about:
            navigationState.navigateTo(.about)
        case .logout:
            navigationState.presentModal(.confirmation(
                title: "Logout",
                message: "Are you sure you want to logout?",
                confirmAction: {
                    print("🚪 User logged out")
                    authManager.logout()
                    onLogout()  // Navigate back to auth screen
                }
            ))
        }
    }
}

// MARK: - Tab Content View
private struct TabContentView: View {
    let tab: TabItem
    @Bindable var navigationState: NavigationState

    var body: some View {
        NavigationStack(path: $navigationState.navigationPath) {
            Group {
                switch tab {
                case .home:
                    MainScreen(
                        onCardTap: { card in
                            print("Card tapped: \(card.title)")
                        },
                        onRefresh: {
                            print("Refresh triggered")
                        }
                    )

                case .search:
                    SearchScreen()

                case .notifications:
                    NotificationsScreen()

                case .profile:
                    ProfileScreen()
                }
            }
            .navigationDestination(for: NavigationScreen.self) { screen in
                NavigationDestinationView(screen: screen)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        navigationState.showSidebar()
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(ColorPalette.textSecondary)
                    }
                }
            }
        }
    }
}

// MARK: - Navigation Destination View
private struct NavigationDestinationView: View {
    let screen: NavigationScreen

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.l) {
                Header(title: screenTitle, subtitle: screenSubtitle)

                switch screen {
                case .settings:
                    SettingsScreen()
                case .help:
                    HelpScreen()
                case .privacy:
                    PrivacyScreen()
                case .terms:
                    TermsScreen()
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

// MARK: - Modal Overlay
private struct ModalOverlay: View {
    let modal: ModalType
    let navigationState: NavigationState

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    navigationState.dismissModal()
                }

            switch modal {
            case .alert(let title, let message, let actions):
                AlertModal(title: title, message: message, actions: actions, navigationState: navigationState)
            case .confirmation(let title, let message, let confirmAction):
                ConfirmationModal(title: title, message: message, confirmAction: confirmAction, navigationState: navigationState)
            case .custom(let content):
                content
            }
        }
    }
}

// MARK: - Sheet Overlay
private struct SheetOverlay: View {
    let sheet: SheetType
    let navigationState: NavigationState

    var body: some View {
        switch sheet {
        case .filters:
            FiltersSheet(navigationState: navigationState)
        case .sort:
            SortSheet(navigationState: navigationState)
        case .share:
            ShareSheet(navigationState: navigationState)
        case .custom(let content):
            content
        }
    }
}

// MARK: - App State
private enum AppState {
    case splash
    case onboarding
    case auth
    case main
}

// MARK: - Alert Modal
private struct AlertModal: View {
    let title: String
    let message: String
    let actions: [AlertAction]
    let navigationState: NavigationState

    var body: some View {
        CardView(padding: .large, backgroundColor: ColorPalette.white) {
            VStack(spacing: Spacing.l) {
                VStack(spacing: Spacing.m) {
                    Text(title)
                        .font(FontStyles.heading2)
                        .foregroundColor(ColorPalette.textPrimary)
                        .multilineTextAlignment(.center)

                    Text(message)
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textSecondary)
                        .multilineTextAlignment(.center)
                }

                VStack(spacing: Spacing.s) {
                    ForEach(actions, id: \.title) { action in
                        switch action.style {
                        case .default:
                            PrimaryButton(action.title, action: action.action)
                        case .destructive:
                            TextButton(action.title, style: .danger, action: action.action)
                        case .cancel:
                            TextButton(action.title, style: .secondary, action: action.action)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: 320)
    }
}

// MARK: - Confirmation Modal
private struct ConfirmationModal: View {
    let title: String
    let message: String
    let confirmAction: () -> Void
    let navigationState: NavigationState

    var body: some View {
        CardView(padding: .large, backgroundColor: ColorPalette.white) {
            VStack(spacing: Spacing.l) {
                VStack(spacing: Spacing.m) {
                    Text(title)
                        .font(FontStyles.heading2)
                        .foregroundColor(ColorPalette.textPrimary)
                        .multilineTextAlignment(.center)

                    Text(message)
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textSecondary)
                        .multilineTextAlignment(.center)
                }

                HStack(spacing: Spacing.m) {
                    TextButton("Cancel", action: {
                        navigationState.dismissModal()
                    })

                    PrimaryButton("Confirm", action: {
                        navigationState.dismissModal()
                        confirmAction()
                    })
                }
            }
        }
        .frame(maxWidth: 320)
    }
}

// MARK: - Placeholder Screens
private struct SearchScreen: View {
    var body: some View {
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

private struct NotificationsScreen: View {
    var body: some View {
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

private struct ProfileScreen: View {
    var body: some View {
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

private struct SettingsScreen: View {
    var body: some View {
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

private struct HelpScreen: View {
    var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Help & Support")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            Text("Help content coming soon...")
                .font(FontStyles.body)
                .foregroundColor(ColorPalette.textSecondary)

            Spacer()
        }
        .padding(Spacing.screenPadding)
        .background(ColorPalette.surface)
    }
}

private struct PrivacyScreen: View {
    var body: some View {
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

private struct TermsScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.l) {
                Text("Terms of Service")
                    .font(FontStyles.heading1)
                    .foregroundColor(ColorPalette.textPrimary)

                Text("Terms of service content would go here...")
                    .font(FontStyles.body)
                    .foregroundColor(ColorPalette.textSecondary)

                Spacer()
            }
            .padding(Spacing.screenPadding)
        }
        .background(ColorPalette.surface)
    }
}

private struct AboutScreen: View {
    var body: some View {
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

// MARK: - Sheet Content Views
private struct FiltersSheet: View {
    let navigationState: NavigationState

    var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Filters")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            VStack(spacing: Spacing.m) {
                TextButton("Filter Option 1", action: {})
                TextButton("Filter Option 2", action: {})
                TextButton("Filter Option 3", action: {})

                PrimaryButton("Apply Filters", action: {
                    navigationState.dismissSheet()
                })
            }

            Spacer()
        }
        .padding(Spacing.xl)
    }
}

private struct SortSheet: View {
    let navigationState: NavigationState

    var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Sort By")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            VStack(spacing: Spacing.m) {
                TextButton("Name A-Z", action: {})
                TextButton("Name Z-A", action: {})
                TextButton("Date Created", action: {})
                TextButton("Date Modified", action: {})

                PrimaryButton("Apply Sort", action: {
                    navigationState.dismissSheet()
                })
            }

            Spacer()
        }
        .padding(Spacing.xl)
    }
}

private struct ShareSheet: View {
    let navigationState: NavigationState

    var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Share")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            VStack(spacing: Spacing.m) {
                TextButton("Share via Message", action: {})
                TextButton("Share via Email", action: {})
                TextButton("Copy Link", action: {})
                TextButton("More Options", action: {})

                PrimaryButton("Done", action: {
                    navigationState.dismissSheet()
                })
            }

            Spacer()
        }
        .padding(Spacing.xl)
    }
}

// MARK: - Preview
#Preview {
    RootView()
}
