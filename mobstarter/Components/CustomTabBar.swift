//
//  CustomTabBar.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct CustomTabBar: View {
    @Binding private var selectedTab: TabItem
    private let tabs: [TabItem]
    private let onTabSelected: ((TabItem) -> Void)?

    public init(
        selectedTab: Binding<TabItem>,
        tabs: [TabItem] = TabItem.allCases,
        onTabSelected: ((TabItem) -> Void)? = nil
    ) {
        self._selectedTab = selectedTab
        self.tabs = tabs
        self.onTabSelected = onTabSelected
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                TabBarItem(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    action: {
                        if selectedTab != tab {
                            selectedTab = tab
                            onTabSelected?(tab)
                        }
                    }
                )
            }
        }
        .padding(.horizontal, Spacing.s)
        .padding(.top, Spacing.s)
        .padding(.bottom, Spacing.s)
        .background(
            ColorPalette.white
                .shadow(color: ColorPalette.gray900.opacity(0.1), radius: 4, x: 0, y: -2)
        )
    }
}

// MARK: - Tab Bar Item
private struct TabBarItem: View {
    let tab: TabItem
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? tab.icon : tab.iconUnselected)
                    .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? ColorPalette.accent : ColorPalette.gray400)

                Text(tab.rawValue)
                    .font(FontStyles.caption)
                    .foregroundColor(isSelected ? ColorPalette.accent : ColorPalette.gray400)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.xs)
            .contentShape(Rectangle())
        }
        .buttonStyle(TabBarButtonStyle())
    }
}

// MARK: - Tab Bar Button Style
private struct TabBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Tab Bar with Badge Support
public struct CustomTabBarWithBadges: View {
    @Binding private var selectedTab: TabItem
    private let tabs: [TabItem]
    private let badgeCounts: [TabItem: Int]
    private let onTabSelected: ((TabItem) -> Void)?

    public init(
        selectedTab: Binding<TabItem>,
        tabs: [TabItem] = TabItem.allCases,
        badgeCounts: [TabItem: Int] = [:],
        onTabSelected: ((TabItem) -> Void)? = nil
    ) {
        self._selectedTab = selectedTab
        self.tabs = tabs
        self.badgeCounts = badgeCounts
        self.onTabSelected = onTabSelected
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                TabBarItemWithBadge(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    badgeCount: badgeCounts[tab] ?? 0,
                    action: {
                        if selectedTab != tab {
                            selectedTab = tab
                            onTabSelected?(tab)
                        }
                    }
                )
            }
        }
        .padding(.horizontal, Spacing.s)
        .padding(.top, Spacing.s)
        .padding(.bottom, Spacing.s)
        .background(
            ColorPalette.white
                .shadow(color: ColorPalette.gray900.opacity(0.1), radius: 4, x: 0, y: -2)
        )
    }
}

// MARK: - Tab Bar Item with Badge
private struct TabBarItemWithBadge: View {
    let tab: TabItem
    let isSelected: Bool
    let badgeCount: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    Image(systemName: isSelected ? tab.icon : tab.iconUnselected)
                        .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                        .foregroundColor(isSelected ? ColorPalette.accent : ColorPalette.gray400)

                    // Badge
                    if badgeCount > 0 {
                        Text("\(min(badgeCount, 99))")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(ColorPalette.white)
                            .frame(minWidth: 16, minHeight: 16)
                            .background(ColorPalette.error)
                            .clipShape(Circle())
                            .offset(x: 10, y: -10)
                            .opacity(isSelected ? 1.0 : 0.7)
                    }
                }

                Text(tab.rawValue)
                    .font(FontStyles.caption)
                    .foregroundColor(isSelected ? ColorPalette.accent : ColorPalette.gray400)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.xs)
            .contentShape(Rectangle())
        }
        .buttonStyle(TabBarButtonStyle())
    }
}

// MARK: - Convenience Initializers
public extension CustomTabBar {
    init(selectedTab: Binding<TabItem>) {
        self.init(selectedTab: selectedTab, tabs: TabItem.allCases)
    }
}

public extension CustomTabBarWithBadges {
    init(selectedTab: Binding<TabItem>) {
        self.init(selectedTab: selectedTab, tabs: TabItem.allCases)
    }

    init(selectedTab: Binding<TabItem>, badgeCounts: [TabItem: Int]) {
        self.init(selectedTab: selectedTab, tabs: TabItem.allCases, badgeCounts: badgeCounts)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 0) {
        Spacer()

        CustomTabBar(selectedTab: .constant(.home))

        CustomTabBarWithBadges(
            selectedTab: .constant(.notifications),
            badgeCounts: [
                .notifications: 3,
                .home: 1
            ]
        )
    }
}
