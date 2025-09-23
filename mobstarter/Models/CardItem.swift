//
//  CardItem.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 23/09/2025.
//

import Foundation

// MARK: - Card Item Model
public struct CardItem: Identifiable, Codable {
    public let id: String  // UUID string for Identifiable
    public let title: String
    public let subtitle: String
    public let description: String
    public let icon: String
    public let timestamp: String
    public let badge: String?
    public let labels: [LabelItem]?

    public init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String,
        description: String,
        icon: String,
        timestamp: String,
        badge: String? = nil,
        labels: [LabelItem]? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.icon = icon
        self.timestamp = timestamp
        self.badge = badge
        self.labels = labels
    }
}

// MARK: - Label Item Model
public struct LabelItem: Identifiable, Codable {
    public let id: String  // UUID string for Identifiable
    public let text: String
    public let icon: String

    public init(id: String = UUID().uuidString, text: String, icon: String) {
        self.id = id
        self.text = text
        self.icon = icon
    }
}

// MARK: - Preview Sample Data
public extension CardItem {
    static var previewCards: [CardItem] {
        [
            CardItem(
                title: "Project Alpha",
                subtitle: "Mobile App Development",
                description: "Working on the new user authentication flow with improved security measures and better UX patterns.",
                icon: "iphone",
                timestamp: "2 hours ago",
                badge: "In Progress",
                labels: [
                    LabelItem(text: "iOS Development", icon: "swift"),
                    LabelItem(text: "UI/UX Design", icon: "paintbrush.fill"),
                    LabelItem(text: "Security", icon: "lock.shield.fill")
                ]
            ),
            CardItem(
                title: "Team Meeting",
                subtitle: "Sprint Planning",
                description: "Weekly standup to discuss progress, blockers, and plan the next sprint activities.",
                icon: "person.3.fill",
                timestamp: "1 day ago",
                labels: [
                    LabelItem(text: "Planning", icon: "calendar"),
                    LabelItem(text: "Team", icon: "person.2.fill")
                ]
            ),
            CardItem(
                title: "Design Review",
                subtitle: "UI/UX Feedback",
                description: "Review session for the new dashboard design with the design team and stakeholders.",
                icon: "paintbrush.fill",
                timestamp: "2 days ago",
                badge: "Completed",
                labels: [
                    LabelItem(text: "Design", icon: "paintpalette.fill"),
                    LabelItem(text: "Feedback", icon: "bubble.left.fill")
                ]
            ),
            CardItem(
                title: "Code Review",
                subtitle: "Feature Branch",
                description: "Review pull request for the new notification system implementation.",
                icon: "checkmark.circle.fill",
                timestamp: "3 days ago",
                labels: [
                    LabelItem(text: "Code Review", icon: "checkmark.circle.fill"),
                    LabelItem(text: "Notifications", icon: "bell.fill")
                ]
            )
        ]
    }
}
