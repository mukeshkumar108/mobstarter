//
//  RootView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

/// Root view that orchestrates the entire app flow and state management
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



// MARK: - Preview
#Preview {
    RootView()
}
