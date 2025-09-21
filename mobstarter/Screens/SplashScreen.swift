//
//  SplashScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct SplashScreen: View {
    private let onContinue: () -> Void
    private let showSkipButton: Bool
    private let animationDuration: Double

    @State private var isAnimating = false
    @State private var showContent = false

    public init(
        onContinue: @escaping () -> Void,
        showSkipButton: Bool = true,
        animationDuration: Double = 2.0
    ) {
        self.onContinue = onContinue
        self.showSkipButton = showSkipButton
        self.animationDuration = animationDuration
    }

    public var body: some View {
        ZStack {
            // Background
            ColorPalette.background
                .ignoresSafeArea()

            VStack(spacing: Spacing.xl) {
                Spacer()

                // Logo/Brand
                VStack(spacing: Spacing.l) {
                    // App Icon or Logo placeholder
                    ZStack {
                        Circle()
                            .fill(ColorPalette.accent)
                            .frame(width: 120, height: 120)
                            .scaleEffect(isAnimating ? 1.0 : 0.8)
                            .opacity(isAnimating ? 1.0 : 0.0)

                        Image(systemName: "star.fill")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(ColorPalette.white)
                            .scaleEffect(isAnimating ? 1.0 : 0.5)
                            .opacity(isAnimating ? 1.0 : 0.0)
                    }

                    if showContent {
                        VStack(spacing: Spacing.s) {
                            Text("Welcome to")
                                .font(FontStyles.heading2)
                                .foregroundColor(ColorPalette.textPrimary)

                            Text("MobStarter")
                                .font(FontStyles.heading1)
                                .foregroundColor(ColorPalette.accent)
                        }
                        .transition(.opacity)
                    }
                }

                Spacer()

                // Action Button
                if showContent {
                    VStack(spacing: Spacing.m) {
                        PrimaryButton("Get Started", action: onContinue)

                        if showSkipButton {
                            TextButton("Skip", action: onContinue)
                        }
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .padding(Spacing.screenPadding)
        }
        .onAppear {
            // Start animations
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                isAnimating = true
            }

            // Show content after logo animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showContent = true
                }
            }
        }
    }
}

// MARK: - Convenience Initializers
public extension SplashScreen {
    init(onContinue: @escaping () -> Void) {
        self.init(onContinue: onContinue, showSkipButton: true)
    }


}

// MARK: - Preview
#Preview {
    SplashScreen(onContinue: {
        print("Continue tapped")
    })
}
