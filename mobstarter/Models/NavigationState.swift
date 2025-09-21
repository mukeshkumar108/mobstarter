//
//  NavigationState.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

// MARK: - Navigation State
@Observable
public class NavigationState {
    // Tab Bar State
    public var selectedTab: TabItem = .home
    public var tabBarHidden: Bool = false

    // Navigation Path
    public var navigationPath = NavigationPath()

    // Sidebar State
    public var sidebarPresented: Bool = false
    public var sidebarSelection: SidebarItem? = nil

    // Modal State
    public var activeModal: ModalType? = nil

    // Sheet State
    public var activeSheet: SheetType? = nil

    // MARK: - Tab Bar Methods
    public func selectTab(_ tab: TabItem) {
        selectedTab = tab
        navigationPath.removeLast(navigationPath.count)
    }

    public func hideTabBar() {
        tabBarHidden = true
    }

    public func showTabBar() {
        tabBarHidden = false
    }

    // MARK: - Navigation Methods
    public func navigateTo(_ screen: NavigationScreen) {
        navigationPath.append(screen)
    }

    public func navigateBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    public func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }

    // MARK: - Sidebar Methods
    public func showSidebar() {
        sidebarPresented = true
    }

    public func hideSidebar() {
        sidebarPresented = false
        sidebarSelection = nil
    }

    public func selectSidebarItem(_ item: SidebarItem) {
        sidebarSelection = item
        hideSidebar()
    }

    // MARK: - Modal Methods
    public func presentModal(_ modal: ModalType) {
        activeModal = modal
    }

    public func dismissModal() {
        activeModal = nil
    }

    // MARK: - Sheet Methods
    public func presentSheet(_ sheet: SheetType) {
        activeSheet = sheet
    }

    public func dismissSheet() {
        activeSheet = nil
    }
}

// MARK: - Tab Items
public enum TabItem: String, CaseIterable, Identifiable {
    case home = "Home"
    case search = "Search"
    case notifications = "Notifications"
    case profile = "Profile"

    public var id: String { rawValue }

    public var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .search:
            return "magnifyingglass"
        case .notifications:
            return "bell.fill"
        case .profile:
            return "person.fill"
        }
    }

    public var iconUnselected: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .notifications:
            return "bell"
        case .profile:
            return "person"
        }
    }
}

// MARK: - Sidebar Items
public enum SidebarItem: String, CaseIterable, Identifiable {
    case settings = "Settings"
    case help = "Help & Support"
    case privacy = "Privacy Policy"
    case terms = "Terms of Service"
    case about = "About"
    case logout = "Logout"

    public var id: String { rawValue }

    public var icon: String {
        switch self {
        case .settings:
            return "gear"
        case .help:
            return "questionmark.circle"
        case .privacy:
            return "hand.raised"
        case .terms:
            return "doc.text"
        case .about:
            return "info.circle"
        case .logout:
            return "arrow.right.square"
        }
    }
}

// MARK: - Navigation Screens
public enum NavigationScreen: Hashable {
    case home
    case search
    case notifications
    case profile
    case settings
    case help
    case privacy
    case terms
    case about
    case custom(String)
}

// MARK: - Modal Types
public enum ModalType: Identifiable {
    case alert(title: String, message: String, actions: [AlertAction])
    case confirmation(title: String, message: String, confirmAction: () -> Void)
    case custom(AnyView)

    public var id: String {
        switch self {
        case .alert(let title, _, _):
            return "alert_\(title)"
        case .confirmation(let title, _, _):
            return "confirmation_\(title)"
        case .custom:
            return "custom_modal"
        }
    }
}

// MARK: - Sheet Types
public enum SheetType: Identifiable {
    case filters
    case sort
    case share
    case custom(AnyView)

    public var id: String {
        switch self {
        case .filters:
            return "filters"
        case .sort:
            return "sort"
        case .share:
            return "share"
        case .custom:
            return "custom_sheet"
        }
    }
}

// MARK: - Alert Action
public struct AlertAction {
    public let title: String
    public let style: AlertActionStyle
    public let action: () -> Void

    public init(title: String, style: AlertActionStyle = .default, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
}

// MARK: - Alert Action Style
public enum AlertActionStyle {
    case `default`
    case destructive
    case cancel
}

// MARK: - Preview
#Preview {
    NavigationState_Previews()
}

private struct NavigationState_Previews: View {
    @State private var navigationState = NavigationState()

    var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Navigation State Preview")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            Text("Current Tab: \(navigationState.selectedTab.rawValue)")
                .font(FontStyles.body)
                .foregroundColor(ColorPalette.textSecondary)

            HStack(spacing: Spacing.m) {
                ForEach(TabItem.allCases) { tab in
                    Button(tab.rawValue) {
                        navigationState.selectTab(tab)
                    }
                    .padding(.horizontal, Spacing.s)
                    .padding(.vertical, Spacing.xs)
                    .background(
                        navigationState.selectedTab == tab ?
                        ColorPalette.accent :
                        ColorPalette.gray200
                    )
                    .foregroundColor(
                        navigationState.selectedTab == tab ?
                        ColorPalette.white :
                        ColorPalette.textPrimary
                    )
                    .cornerRadius(CornerRadius.s)
                }
            }

            VStack(spacing: Spacing.s) {
                Button("Show Sidebar") {
                    navigationState.showSidebar()
                }
                .buttonStyle(.plain)

                Button("Present Modal") {
                    navigationState.presentModal(.alert(
                        title: "Test Alert",
                        message: "This is a test alert message.",
                        actions: [
                            AlertAction(title: "OK", action: {}),
                            AlertAction(title: "Cancel", style: .cancel, action: {})
                        ]
                    ))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(Spacing.screenPadding)
    }
}
