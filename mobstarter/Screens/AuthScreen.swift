//
//  AuthScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct AuthScreen: View {
    private let authManager: AuthenticationManager
    private let onLoginSuccess: () -> Void
    private let onSignUp: (() -> Void)?
    private let onForgotPassword: (() -> Void)?

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSignUp = false
    @State private var rememberMe = false

    // Validation states
    @State private var emailError: String?
    @State private var passwordError: String?
    @State private var confirmPasswordError: String?

    public init(
        authManager: AuthenticationManager,
        onLoginSuccess: @escaping () -> Void,
        onSignUp: (() -> Void)? = nil,
        onForgotPassword: (() -> Void)? = nil
    ) {
        self.authManager = authManager
        self.onLoginSuccess = onLoginSuccess
        self.onSignUp = onSignUp
        self.onForgotPassword = onForgotPassword
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // Header
                VStack(spacing: Spacing.s) {
                    Text(isSignUp ? "Create Account" : "Welcome Back")
                        .font(FontStyles.heading1)
                        .foregroundColor(ColorPalette.textPrimary)

                    Text(isSignUp ? "Sign up to get started" : "Sign in to your account")
                        .font(FontStyles.body)
                        .foregroundColor(ColorPalette.textSecondary)
                }
                .padding(.top, Spacing.xl)

                // Form
                VStack(spacing: Spacing.l) {
                    // Email Field
                    CustomTextField(
                        "Email address",
                        text: $email,
                        icon: Image(systemName: "envelope"),
                        keyboardType: .emailAddress,
                        errorMessage: emailError
                    )

                    // Password Field
                    CustomTextField(
                        "Password",
                        text: $password,
                        icon: Image(systemName: "lock.fill"),
                        isSecure: true,
                        errorMessage: passwordError
                    )

                    // Confirm Password (Sign Up only)
                    if isSignUp {
                        CustomTextField(
                            "Confirm Password",
                            text: $confirmPassword,
                            icon: Image(systemName: "lock.fill"),
                            isSecure: true,
                            errorMessage: confirmPasswordError
                        )
                    }

                    // Remember Me & Forgot Password
                    HStack {
                        // Remember Me
                        Toggle(isOn: $rememberMe) {
                            Text("Remember me")
                                .font(FontStyles.bodySmall)
                                .foregroundColor(ColorPalette.textSecondary)
                        }
                        .toggleStyle(CheckboxToggleStyle())

                        Spacer()

                        // Forgot Password
                        if !isSignUp, let onForgotPassword = onForgotPassword {
                            Button(action: onForgotPassword) {
                                Text("Forgot password?")
                                    .font(FontStyles.bodySmall)
                                    .foregroundColor(ColorPalette.accent)
                            }
                        }
                    }
                }

                // Action Button
                PrimaryButton(
                    isSignUp ? "Create Account" : "Sign In",
                    isLoading: authManager.isLoading,
                    action: {
                        Task {
                            await handleAuthAction()
                        }
                    }
                )

                // Toggle Sign In/Sign Up
                if let onSignUp = onSignUp {
                    HStack(spacing: Spacing.xs) {
                        Text(isSignUp ? "Already have an account?" : "Don't have an account?")
                            .font(FontStyles.body)
                            .foregroundColor(ColorPalette.textSecondary)

                        Button(action: {
                            withAnimation {
                                isSignUp.toggle()
                                clearErrors()
                            }
                        }) {
                            Text(isSignUp ? "Sign In" : "Sign Up")
                                .font(FontStyles.body)
                                .foregroundColor(ColorPalette.accent)
                        }
                    }
                }
            }
            .padding(Spacing.screenPadding)
        }
        .background(ColorPalette.background)
        .onTapGesture {
            hideKeyboard()
        }
    }

    private func handleAuthAction() async {
        clearErrors()

        // Validate form
        var hasErrors = false

        if email.isEmpty || !isValidEmail(email) {
            emailError = "Please enter a valid email address"
            hasErrors = true
        }

        if password.isEmpty || password.count < 6 {
            passwordError = "Password must be at least 6 characters"
            hasErrors = true
        }

        if isSignUp {
            if confirmPassword.isEmpty {
                confirmPasswordError = "Please confirm your password"
                hasErrors = true
            } else if password != confirmPassword {
                confirmPasswordError = "Passwords do not match"
                hasErrors = true
            }
        }

        guard !hasErrors else { return }

        // Perform authentication using AuthenticationManager
        let success = await authManager.login(email: email, password: password)

        if success {
            print("✅ Login successful, navigating to main app")
            onLoginSuccess()
        } else {
            // Error message is already set in AuthenticationManager
            print("❌ Login failed: \(authManager.errorMessage ?? "Unknown error")")
        }
    }

    private func clearErrors() {
        emailError = nil
        passwordError = nil
        confirmPasswordError = nil
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Checkbox Toggle Style
private struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .foregroundColor(configuration.isOn ? ColorPalette.accent : ColorPalette.gray300)
                .font(.system(size: 16, weight: .regular))
                .onTapGesture {
                    configuration.isOn.toggle()
                }

            configuration.label
        }
    }
}



// MARK: - Preview
#Preview {
    AuthScreen(
        authManager: AuthenticationManager(),
        onLoginSuccess: {
            print("Login successful")
        },
        onSignUp: {
            print("Navigate to sign up")
        },
        onForgotPassword: {
            print("Navigate to forgot password")
        }
    )
}
