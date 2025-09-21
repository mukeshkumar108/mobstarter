//
//  Header.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct Header: View {
    private let title: String
    private let subtitle: String?
    private let leftAction: HeaderAction?
    private let rightAction: HeaderAction?
    private let style: HeaderStyle
    private let showDivider: Bool

    public init(
        title: String,
        subtitle: String? = nil,
        leftAction: HeaderAction? = nil,
        rightAction: HeaderAction? = nil,
        style: HeaderStyle = .standard,
        showDivider: Bool = true
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leftAction = leftAction
        self.rightAction = rightAction
        self.style = style
        self.showDivider = showDivider
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: Spacing.s) {
                // Left Action
                if let leftAction = leftAction {
                    Button(action: leftAction.action) {
                        leftAction.icon
                            .imageScale(.large)
                            .foregroundColor(ColorPalette.textSecondary)
                            .frame(width: 44, height: 44)
                    }
                }

                // Center Content
                VStack(alignment: .center, spacing: style == .compact ? 0 : Spacing.xs) {
                    Text(title)
                        .font(titleFont)
                        .foregroundColor(ColorPalette.textPrimary)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .center)

                    if let subtitle = subtitle, style != .compact {
                        Text(subtitle)
                            .font(FontStyles.caption)
                            .foregroundColor(ColorPalette.textSecondary)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }

                // Right Action
                if let rightAction = rightAction {
                    Button(action: rightAction.action) {
                        rightAction.icon
                            .imageScale(.large)
                            .foregroundColor(ColorPalette.textSecondary)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
            .padding(.vertical, Spacing.m)
            .frame(height: headerHeight)

            // Divider
            if showDivider {
                Divider()
                    .background(ColorPalette.gray200)
            }
        }
        .background(ColorPalette.background)
    }

    private var titleFont: Font {
        switch style {
        case .standard:
            return FontStyles.heading2
        case .compact:
            return FontStyles.body
        case .large:
            return FontStyles.heading1
        }
    }

    private var headerHeight: CGFloat {
        switch style {
        case .standard:
            return subtitle != nil ? 80 : 60
        case .compact:
            return 50
        case .large:
            return 100
        }
    }
}

// MARK: - Header Action
public struct HeaderAction {
    let icon: Image
    let action: () -> Void

    public init(icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
}

// MARK: - Header Styles
public enum HeaderStyle {
    case standard     // Regular header with optional subtitle
    case compact      // Smaller header, no subtitle
    case large        // Larger header for important screens
}

// MARK: - Convenience Initializers
public extension Header {
    init(title: String) {
        self.init(title: title, style: .standard)
    }

    init(title: String, subtitle: String) {
        self.init(title: title, subtitle: subtitle, style: .standard)
    }

    init(title: String, leftAction: HeaderAction) {
        self.init(title: title, leftAction: leftAction, style: .standard)
    }

    init(title: String, rightAction: HeaderAction) {
        self.init(title: title, rightAction: rightAction, style: .standard)
    }

    init(title: String, leftAction: HeaderAction, rightAction: HeaderAction) {
        self.init(title: title, leftAction: leftAction, rightAction: rightAction, style: .standard)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 0) {
        Header(title: "Settings", subtitle: "Manage your account")
        Header(title: "Profile", leftAction: HeaderAction(icon: Image(systemName: "arrow.left"), action: {}))
        Header(title: "Notifications", rightAction: HeaderAction(icon: Image(systemName: "gear"), action: {}))
        Header(
            title: "Messages",
            leftAction: HeaderAction(icon: Image(systemName: "arrow.left"), action: {}),
            rightAction: HeaderAction(icon: Image(systemName: "plus"), action: {})
        )
        Header(title: "Compact", style: .compact)
        Header(title: "Large Header", style: .large)
    }
}
