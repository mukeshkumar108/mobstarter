//
//  CustomTextField.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct CustomTextField: View {
    private let placeholder: String
    private let text: Binding<String>
    private let style: TextFieldStyle
    private let icon: Image?
    private let isSecure: Bool
    private let keyboardType: UIKeyboardType
    private let autocapitalization: TextInputAutocapitalization
    private let errorMessage: String?
    private let helperText: String?

    public init(
        _ placeholder: String,
        text: Binding<String>,
        style: TextFieldStyle = .standard,
        icon: Image? = nil,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: TextInputAutocapitalization = .sentences,
        errorMessage: String? = nil,
        helperText: String? = nil
    ) {
        self.placeholder = placeholder
        self.text = text
        self.style = style
        self.icon = icon
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.errorMessage = errorMessage
        self.helperText = helperText
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            // Input Field
            HStack(spacing: Spacing.s) {
                if let icon = icon {
                    icon
                        .imageScale(.medium)
                        .frame(width: 20, height: 20)
                        .foregroundColor(ColorPalette.gray400)
                }

                Group {
                    if isSecure {
                        SecureField(placeholder, text: text)
                    } else {
                        TextField(placeholder, text: text)
                    }
                }
                .font(FontStyles.body)
                .foregroundColor(ColorPalette.textPrimary)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled(keyboardType == .emailAddress)
            }
            .padding(.horizontal, Spacing.m)
            .padding(.vertical, Spacing.m)
            .background(
                errorMessage != nil ?
                ColorPalette.error.opacity(0.05) :
                ColorPalette.surface
            )
            .cornerRadius(CornerRadius.default)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.default)
                    .stroke(borderColor, lineWidth: 1)
            )

            // Helper Text or Error Message
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(FontStyles.caption)
                    .foregroundColor(ColorPalette.error)
                    .padding(.leading, Spacing.xs)
            } else if let helperText = helperText {
                Text(helperText)
                    .font(FontStyles.caption)
                    .foregroundColor(ColorPalette.textTertiary)
                    .padding(.leading, Spacing.xs)
            }
        }
    }

    private var borderColor: Color {
        if let errorMessage = errorMessage {
            return ColorPalette.error
        } else if !text.wrappedValue.isEmpty {
            return ColorPalette.accent
        } else {
            return ColorPalette.gray300
        }
    }
}

// MARK: - Text Field Styles
public enum TextFieldStyle {
    case standard
    case outlined
    case filled
}

// MARK: - Convenience Initializers
public extension CustomTextField {
    init(_ placeholder: String, text: Binding<String>) {
        self.init(placeholder, text: text, style: .standard)
    }

    init(_ placeholder: String, text: Binding<String>, icon: Image) {
        self.init(placeholder, text: text, style: .standard, icon: icon)
    }

    init(_ placeholder: String, text: Binding<String>, isSecure: Bool) {
        self.init(placeholder, text: text, style: .standard, isSecure: isSecure)
    }

    init(_ placeholder: String, text: Binding<String>, errorMessage: String) {
        self.init(placeholder, text: text, style: .standard, errorMessage: errorMessage)
    }
}

// MARK: - Preview
#Preview {
    @State var email = ""
    @State var password = ""
    @State var invalidEmail = ""

    VStack(spacing: Spacing.l) {
        CustomTextField("Email address", text: $email, icon: Image(systemName: "envelope"))
        CustomTextField("Password", text: $password, icon: Image(systemName: "lock"), isSecure: true)
        CustomTextField("Invalid email", text: $invalidEmail, errorMessage: "Please enter a valid email address")

        Text("Helper text example:")
            .font(FontStyles.caption)
            .foregroundColor(ColorPalette.textSecondary)
        CustomTextField("Username", text: $email, helperText: "Choose a unique username")
    }
    .padding(Spacing.screenPadding)
}
