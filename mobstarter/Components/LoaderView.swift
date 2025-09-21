//
//  LoaderView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct LoaderView: View {
    private let style: LoaderStyle
    private let message: String?
    private let size: LoaderSize

    public init(
        style: LoaderStyle = .circular,
        message: String? = nil,
        size: LoaderSize = .medium
    ) {
        self.style = style
        self.message = message
        self.size = size
    }

    public var body: some View {
        VStack(spacing: Spacing.m) {
            loaderContent

            if let message = message {
                Text(message)
                    .font(FontStyles.bodySmall)
                    .foregroundColor(ColorPalette.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(Spacing.xl)
    }

    @ViewBuilder
    private var loaderContent: some View {
        switch style {
        case .circular:
            CircularLoader(size: size)
        case .pulse:
            PulseLoader(size: size)
        case .dots:
            DotsLoader(size: size)
        case .bars:
            BarsLoader(size: size)
        }
    }
}

// MARK: - Loader Styles
public enum LoaderStyle {
    case circular
    case pulse
    case dots
    case bars
}

// MARK: - Loader Sizes
public enum LoaderSize {
    case small
    case medium
    case large

    var dimension: CGFloat {
        switch self {
        case .small:
            return 24
        case .medium:
            return 40
        case .large:
            return 56
        }
    }

    var strokeWidth: CGFloat {
        switch self {
        case .small:
            return 2
        case .medium:
            return 3
        case .large:
            return 4
        }
    }
}

// MARK: - Circular Loader
private struct CircularLoader: View {
    let size: LoaderSize

    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: ColorPalette.accent))
            .frame(width: size.dimension, height: size.dimension)
            .scaleEffect(1.2)
    }
}

// MARK: - Pulse Loader
private struct PulseLoader: View {
    let size: LoaderSize
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .fill(ColorPalette.accent)
            .frame(width: size.dimension, height: size.dimension)
            .scaleEffect(isAnimating ? 1.2 : 0.8)
            .opacity(isAnimating ? 0.6 : 1.0)
            .animation(
                Animation.easeInOut(duration: 1.0)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

// MARK: - Dots Loader
private struct DotsLoader: View {
    let size: LoaderSize
    @State private var isAnimating = false

    var body: some View {
        HStack(spacing: size.strokeWidth) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(ColorPalette.accent)
                    .frame(width: size.strokeWidth * 2, height: size.strokeWidth * 2)
                    .scaleEffect(isAnimating ? 0.5 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Bars Loader
private struct BarsLoader: View {
    let size: LoaderSize
    @State private var isAnimating = false

    var body: some View {
        HStack(spacing: size.strokeWidth) {
            ForEach(0..<4) { index in
                RoundedRectangle(cornerRadius: size.strokeWidth / 2)
                    .fill(ColorPalette.accent)
                    .frame(width: size.strokeWidth * 2, height: size.dimension)
                    .scaleEffect(y: isAnimating ? 0.4 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Convenience Initializers
public extension LoaderView {
    init() {
        self.init(style: .circular, message: nil, size: .medium)
    }

    init(message: String) {
        self.init(style: .circular, message: message, size: .medium)
    }

    init(style: LoaderStyle) {
        self.init(style: style, message: nil, size: .medium)
    }

    init(size: LoaderSize) {
        self.init(style: .circular, message: nil, size: size)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: Spacing.xl) {
        LoaderView(message: "Loading content...")

        LoaderView(style: .pulse, message: "Processing...")

        LoaderView(style: .dots, message: "Please wait...")

        LoaderView(style: .bars, message: "Almost done...")

        HStack(spacing: Spacing.l) {
            LoaderView(size: .small)
            LoaderView(size: .medium)
            LoaderView(size: .large)
        }
    }
    .padding(Spacing.screenPadding)
}
