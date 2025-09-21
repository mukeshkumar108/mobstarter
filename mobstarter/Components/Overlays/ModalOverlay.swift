//
//  ModalOverlay.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

/// Global modal overlay that handles different types of modals
public struct ModalOverlay: View {
    let modal: ModalType
    let navigationState: NavigationState

    public var body: some View {
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

// MARK: - Preview
#Preview {
    ModalOverlay(
        modal: .alert(
            title: "Test Alert",
            message: "This is a test alert modal",
            actions: [
                AlertAction(title: "OK", style: .default, action: {}),
                AlertAction(title: "Cancel", style: .cancel, action: {})
            ]
        ),
        navigationState: NavigationState()
    )
}
