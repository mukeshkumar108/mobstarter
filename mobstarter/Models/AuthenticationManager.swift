//
//  AuthenticationManager.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

// MARK: - User Model (Placeholder for future Supabase integration)
public struct User {
    public let id: String
    public let email: String
    public let name: String?

    public init(id: String, email: String, name: String? = nil) {
        self.id = id
        self.email = email
        self.name = name
    }
}

// MARK: - Authentication Manager
@Observable
public class AuthenticationManager {
    // MARK: - Published Properties
    public private(set) var isLoggedIn: Bool = false
    public private(set) var currentUser: User? = nil
    public private(set) var isLoading: Bool = false
    public private(set) var errorMessage: String? = nil

    // MARK: - Constants
    private let userDefaultsKey = "mobstarter_auth_state"

    // MARK: - Initialization
    public init() {
        loadState()
    }

    // MARK: - Authentication Methods
    public func login(email: String, password: String) async -> Bool {
        // Reset error state
        await MainActor.run {
            errorMessage = nil
            isLoading = true
        }

        // Validate input
        guard !email.isEmpty && !password.isEmpty else {
            await MainActor.run {
                errorMessage = "Email and password are required"
                isLoading = false
            }
            return false
        }

        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds

        // For demo purposes, any non-empty email/password succeeds
        let success = !email.isEmpty && !password.isEmpty

        await MainActor.run {
            if success {
                // Create a dummy user (in real app, this would come from backend)
                let user = User(
                    id: UUID().uuidString,
                    email: email,
                    name: email.components(separatedBy: "@").first?.capitalized
                )

                self.currentUser = user
                self.isLoggedIn = true
                self.saveState()
                print("✅ Login successful for: \(email)")
            } else {
                self.errorMessage = "Login failed. Please try again."
                print("❌ Login failed for: \(email)")
            }

            self.isLoading = false
        }

        return success
    }

    public func logout() {
        print("🚪 User logged out")
        isLoggedIn = false
        currentUser = nil
        saveState()
    }

    // MARK: - State Persistence
    private func saveState() {
        let state: [String: String] = [
            "isLoggedIn": String(isLoggedIn),
            "userId": currentUser?.id ?? "",
            "userEmail": currentUser?.email ?? "",
            "userName": currentUser?.name ?? ""
        ]

        UserDefaults.standard.set(state, forKey: userDefaultsKey)
        print("💾 Auth state saved: isLoggedIn = \(isLoggedIn)")
    }

    private func loadState() {
        guard let state = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: String] else {
            print("📱 No saved auth state found")
            return
        }

        let isLoggedIn = state["isLoggedIn"] == "true"
        let userId = state["userId"] ?? ""
        let userEmail = state["userEmail"] ?? ""
        let userName = state["userName"] ?? ""

        if isLoggedIn && !userEmail.isEmpty {
            self.isLoggedIn = true
            self.currentUser = User(id: userId, email: userEmail, name: userName)
            print("📱 Auth state loaded: isLoggedIn = \(isLoggedIn), user = \(userEmail)")
        } else {
            print("📱 Auth state loaded: not logged in")
        }
    }

    // MARK: - Helper Methods
    public func clearError() {
        errorMessage = nil
    }

    public var isAuthenticated: Bool {
        return isLoggedIn && currentUser != nil
    }
}

// MARK: - Preview
#Preview {
    AuthenticationManager_Previews()
}

private struct AuthenticationManager_Previews: View {
    @State private var authManager = AuthenticationManager()

    var body: some View {
        VStack(spacing: Spacing.l) {
            Text("Authentication Manager Preview")
                .font(FontStyles.heading2)
                .foregroundColor(ColorPalette.textPrimary)

            VStack(alignment: .leading, spacing: Spacing.s) {
                Text("Status: \(authManager.isLoggedIn ? "Logged In" : "Logged Out")")
                    .font(FontStyles.body)
                    .foregroundColor(authManager.isLoggedIn ? ColorPalette.success : ColorPalette.textSecondary)

                if let user = authManager.currentUser {
                    Text("User: \(user.email)")
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textPrimary)
                }

                if let error = authManager.errorMessage {
                    Text("Error: \(error)")
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.error)
                }
            }
            .padding(Spacing.screenPadding)
            .background(ColorPalette.surface)
            .cornerRadius(CornerRadius.default)

            VStack(spacing: Spacing.m) {
                Button("Login (test@example.com)") {
                    Task {
                        let success = await authManager.login(email: "test@example.com", password: "password123")
                        print("Login result: \(success)")
                    }
                }
                .buttonStyle(.plain)
                .padding(.horizontal, Spacing.m)
                .padding(.vertical, Spacing.s)
                .background(ColorPalette.accent)
                .foregroundColor(ColorPalette.white)
                .cornerRadius(CornerRadius.s)

                Button("Logout") {
                    authManager.logout()
                }
                .buttonStyle(.plain)
                .padding(.horizontal, Spacing.m)
                .padding(.vertical, Spacing.s)
                .background(ColorPalette.gray300)
                .foregroundColor(ColorPalette.textPrimary)
                .cornerRadius(CornerRadius.s)
            }
        }
        .padding(Spacing.screenPadding)
    }
}
