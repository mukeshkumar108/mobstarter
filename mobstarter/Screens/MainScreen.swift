//
//  MainScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct MainScreen: View {
    private let onCardTap: (CardItem) -> Void
    private let onRefresh: () -> Void

    @State private var isRefreshing = false
    @State private var showDemoModal = false
    @State private var showDemoSheet = false

    public init(
        onCardTap: @escaping (CardItem) -> Void,
        onRefresh: @escaping () -> Void
    ) {
        self.onCardTap = onCardTap
        self.onRefresh = onRefresh
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: Spacing.l) {
                // Header
                Header(
                    title: "Dashboard",
                    subtitle: "Welcome back! Here's what's new.",
                    rightAction: HeaderAction(
                        icon: Image(systemName: "line.horizontal.3"),
                        action: {
                            print("Menu tapped")
                        }
                    )
                )

                // Quick Actions
                VStack(alignment: .leading, spacing: Spacing.m) {
                    Text("Quick Actions")
                        .font(FontStyles.heading3)
                        .foregroundColor(ColorPalette.textPrimary)

                    HStack(spacing: Spacing.s) {
                        TextButton("Demo Modal", action: {
                            showDemoModal = true
                        })

                        TextButton("Demo Sheet", action: {
                            showDemoSheet = true
                        })

                        Spacer()

                        TextButton("Refresh", action: {
                            handleRefresh()
                        })
                    }
                }

                // Cards Section
                VStack(alignment: .leading, spacing: Spacing.m) {
                    Text("Recent Activity")
                        .font(FontStyles.heading3)
                        .foregroundColor(ColorPalette.textPrimary)

                    // Stacked Cards
                    VStack(spacing: Spacing.m) {
                        ForEach(MainScreen.sampleCards) { card in
                            CardView(
                                padding: .large,
                                onTap: {
                                    onCardTap(card)
                                }
                            ) {
                                VStack(alignment: .leading, spacing: Spacing.s) {
                                    // Card Header
                                    HStack {
                                        Image(systemName: card.icon)
                                            .font(.system(size: 24, weight: .semibold))
                                            .foregroundColor(ColorPalette.accent)

                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(card.title)
                                                .font(FontStyles.heading3)
                                                .foregroundColor(ColorPalette.textPrimary)

                                            Text(card.subtitle)
                                                .font(FontStyles.caption)
                                                .foregroundColor(ColorPalette.textSecondary)
                                        }

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .foregroundColor(ColorPalette.gray400)
                                    }

                                    // Card Content
                                    Text(card.description)
                                        .font(FontStyles.body)
                                        .foregroundColor(ColorPalette.textSecondary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)

                                    // Card Footer
                                    HStack {
                                        Text(card.timestamp)
                                            .font(FontStyles.caption)
                                            .foregroundColor(ColorPalette.textTertiary)

                                        Spacer()

                                        if card.badge != nil {
                                            Text(card.badge!)
                                                .font(FontStyles.caption)
                                                .foregroundColor(ColorPalette.white)
                                                .padding(.horizontal, Spacing.s)
                                                .padding(.vertical, 2)
                                                .background(ColorPalette.accent)
                                                .cornerRadius(CornerRadius.s)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Stats Section
                VStack(alignment: .leading, spacing: Spacing.m) {
                    Text("Your Stats")
                        .font(FontStyles.heading3)
                        .foregroundColor(ColorPalette.textPrimary)

                    HStack(spacing: Spacing.s) {
                        StatCard(
                            title: "Total Items",
                            value: "24",
                            icon: "list.bullet",
                            color: ColorPalette.accent
                        )

                        StatCard(
                            title: "Completed",
                            value: "18",
                            icon: "checkmark.circle.fill",
                            color: ColorPalette.success
                        )

                        StatCard(
                            title: "Pending",
                            value: "6",
                            icon: "clock.fill",
                            color: ColorPalette.warning
                        )
                    }
                }
            }
            .padding(Spacing.screenPadding)
        }
        .background(ColorPalette.surface)
        .refreshable {
            await handleRefreshAsync()
        }
        // Demo Modal
        .sheet(isPresented: $showDemoModal) {
            DemoModal(isPresented: $showDemoModal)
        }
        // Demo Sheet
        .sheet(isPresented: $showDemoSheet) {
            DemoSheet(isPresented: $showDemoSheet)
        }
    }

    private func handleRefresh() {
        Task {
            await handleRefreshAsync()
        }
    }

    private func handleRefreshAsync() async {
        isRefreshing = true
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        onRefresh()
        isRefreshing = false
    }
}

// MARK: - Card Item Model
public struct CardItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let subtitle: String
    public let description: String
    public let icon: String
    public let timestamp: String
    public let badge: String?

    public init(
        title: String,
        subtitle: String,
        description: String,
        icon: String,
        timestamp: String,
        badge: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.icon = icon
        self.timestamp = timestamp
        self.badge = badge
    }
}

// MARK: - Stat Card
private struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        CardView(padding: .medium, backgroundColor: ColorPalette.white) {
            VStack(alignment: .leading, spacing: Spacing.s) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 20, weight: .semibold))

                    Spacer()
                }

                Text(value)
                    .font(FontStyles.heading2)
                    .foregroundColor(ColorPalette.textPrimary)

                Text(title)
                    .font(FontStyles.caption)
                    .foregroundColor(ColorPalette.textSecondary)
            }
        }
    }
}

// MARK: - Demo Modal
private struct DemoModal: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Demo Modal")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            Text("This is a demo modal showing how modals work in the app.")
                .font(FontStyles.body)
                .foregroundColor(ColorPalette.textSecondary)
                .multilineTextAlignment(.center)

            VStack(spacing: Spacing.m) {
                PrimaryButton("Close Modal", action: {
                    isPresented = false
                })

                TextButton("Secondary Action", action: {})
            }
        }
        .padding(Spacing.xl)
        .presentationDetents([.medium])
    }
}

// MARK: - Demo Sheet
private struct DemoSheet: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Demo Bottom Sheet")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            Text("This is a demo bottom sheet with multiple options.")
                .font(FontStyles.body)
                .foregroundColor(ColorPalette.textSecondary)
                .multilineTextAlignment(.center)

            VStack(spacing: Spacing.m) {
                TextButton("Option 1", action: {})
                TextButton("Option 2", action: {})
                TextButton("Option 3", action: {})

                PrimaryButton("Done", action: {
                    isPresented = false
                })
            }
        }
        .padding(Spacing.xl)
    }
}

// MARK: - Sample Data
public extension MainScreen {
    static var sampleCards: [CardItem] {
        [
            CardItem(
                title: "Project Alpha",
                subtitle: "Mobile App Development",
                description: "Working on the new user authentication flow with improved security measures and better UX patterns.",
                icon: "iphone",
                timestamp: "2 hours ago",
                badge: "In Progress"
            ),
            CardItem(
                title: "Team Meeting",
                subtitle: "Sprint Planning",
                description: "Weekly standup to discuss progress, blockers, and plan the next sprint activities.",
                icon: "person.3.fill",
                timestamp: "1 day ago"
            ),
            CardItem(
                title: "Design Review",
                subtitle: "UI/UX Feedback",
                description: "Review session for the new dashboard design with the design team and stakeholders.",
                icon: "paintbrush.fill",
                timestamp: "2 days ago"
            ),
            CardItem(
                title: "Code Review",
                subtitle: "Feature Branch",
                description: "Review pull request for the new notification system implementation.",
                icon: "checkmark.circle.fill",
                timestamp: "3 days ago"
            )
        ]
    }
}

// MARK: - Preview
#Preview {
    MainScreen(
        onCardTap: { card in
            print("Card tapped: \(card.title)")
        },
        onRefresh: {
            print("Refresh triggered")
        }
    )
}
