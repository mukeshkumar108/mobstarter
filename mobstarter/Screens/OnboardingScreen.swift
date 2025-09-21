//
//  OnboardingScreen.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct OnboardingScreen: View {
    private let slides: [OnboardingSlide]
    private let onComplete: () -> Void
    private let showSkipButton: Bool

    @State private var currentIndex = 0
    @State private var isAnimating = false

    public init(
        slides: [OnboardingSlide],
        onComplete: @escaping () -> Void,
        showSkipButton: Bool = true
    ) {
        self.slides = slides
        self.onComplete = onComplete
        self.showSkipButton = showSkipButton
    }

    public var body: some View {
        ZStack {
            // Background
            ColorPalette.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    if showSkipButton {
                        TextButton("Skip", action: onComplete)
                            .padding(.leading, Spacing.screenPadding)
                    }

                    Spacer()

                    // Page indicator
                    HStack(spacing: Spacing.xs) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            Circle()
                                .fill(currentIndex == index ? ColorPalette.accent : ColorPalette.gray300)
                                .frame(width: 8, height: 8)
                                .scaleEffect(currentIndex == index ? 1.2 : 1.0)
                        }
                    }
                    .padding(.trailing, Spacing.screenPadding)
                }
                .padding(.top, Spacing.xl)

                // Content
                TabView(selection: $currentIndex) {
                    ForEach(slides.indices, id: \.self) { index in
                        OnboardingSlideView(slide: slides[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentIndex)

                // Bottom Controls
                VStack(spacing: Spacing.m) {
                    // Next/Continue Button
                    if currentIndex == slides.count - 1 {
                        PrimaryButton("Get Started", action: onComplete)
                    } else {
                        PrimaryButton("Next", action: {
                            withAnimation {
                                currentIndex += 1
                            }
                        })
                    }

                    // Previous Button (if not first slide)
                    if currentIndex > 0 {
                        TextButton("Previous", action: {
                            withAnimation {
                                currentIndex -= 1
                            }
                        })
                        .transition(.opacity)
                    }
                }
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.bottom, Spacing.xl)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Onboarding Slide View
private struct OnboardingSlideView: View {
    let slide: OnboardingSlide

    var body: some View {
        VStack(spacing: Spacing.xl) {
            Spacer()

            // Illustration/Image
            ZStack {
                Circle()
                    .fill(ColorPalette.accent.opacity(0.1))
                    .frame(width: 200, height: 200)

                Image(systemName: slide.icon)
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(ColorPalette.accent)
            }

            // Content
            VStack(spacing: Spacing.m) {
                Text(slide.title)
                    .font(FontStyles.heading1)
                    .foregroundColor(ColorPalette.textPrimary)
                    .multilineTextAlignment(.center)

                Text(slide.description)
                    .font(FontStyles.body)
                    .foregroundColor(ColorPalette.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.l)
            }

            Spacer()
        }
        .padding(Spacing.screenPadding)
    }
}

// MARK: - Onboarding Slide Model
public struct OnboardingSlide: Identifiable {
    public let id = UUID()
    public let title: String
    public let description: String
    public let icon: String

    public init(title: String, description: String, icon: String) {
        self.title = title
        self.description = description
        self.icon = icon
    }
}

// MARK: - Convenience Initializers
public extension OnboardingScreen {
    init(onComplete: @escaping () -> Void) {
        self.init(slides: OnboardingScreen.defaultSlides, onComplete: onComplete)
    }

    init(slides: [OnboardingSlide], onComplete: @escaping () -> Void) {
        self.init(slides: slides, onComplete: onComplete, showSkipButton: true)
    }
}

// MARK: - Default Slides
public extension OnboardingScreen {
    static var defaultSlides: [OnboardingSlide] {
        [
            OnboardingSlide(
                title: "Welcome",
                description: "Discover a new way to manage your tasks and boost your productivity with our intuitive interface.",
                icon: "star.fill"
            ),
            OnboardingSlide(
                title: "Stay Organized",
                description: "Keep track of your projects, set reminders, and never miss an important deadline again.",
                icon: "checkmark.circle.fill"
            ),
            OnboardingSlide(
                title: "Collaborate",
                description: "Work seamlessly with your team, share progress, and achieve your goals together.",
                icon: "person.3.fill"
            ),
            OnboardingSlide(
                title: "Get Started",
                description: "You're all set! Start exploring the features and make the most out of your experience.",
                icon: "rocket.fill"
            )
        ]
    }
}

// MARK: - Preview
#Preview {
    OnboardingScreen(onComplete: {
        print("Onboarding completed")
    })
}
