//
//  SheetOverlay.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

/// Global sheet overlay that handles different types of sheets
public struct SheetOverlay: View {
    let sheet: SheetType
    let navigationState: NavigationState

    public var body: some View {
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
    SheetOverlay(
        sheet: .filters,
        navigationState: NavigationState()
    )
}
