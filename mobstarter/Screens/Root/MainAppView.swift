//
//  MainAppView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

/// Main app view containing the tab bar and sidebar navigation
public struct MainAppView: View {
    @Bindable var navigationState: NavigationState
    let authManager: AuthenticationManager
    let onLogout: () -> Void

    public var body: some View {
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
                    HomeScreen(
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

// MARK: - Preview
#Preview {
    MainAppView(
        navigationState: NavigationState(),
        authManager: AuthenticationManager(),
        onLogout: {
            print("Logout triggered")
        }
    )
}
