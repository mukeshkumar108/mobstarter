//
//  CustomSheet.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct CustomSheet<Content: View>: View {
    private let content: Content
    private let isPresented: Binding<Bool>
    private let detents: [SheetDetent]
    private let showHandle: Bool
    private let backgroundColor: Color
    private let onDismiss: (() -> Void)?

    public init(
        isPresented: Binding<Bool>,
        detents: [SheetDetent] = [.medium, .large],
        showHandle: Bool = true,
        backgroundColor: Color = ColorPalette.white,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.isPresented = isPresented
        self.detents = detents
        self.showHandle = showHandle
        self.backgroundColor = backgroundColor
        self.onDismiss = onDismiss
    }

    public var body: some View {
        ZStack {
            // Backdrop
            if isPresented.wrappedValue {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        if let onDismiss = onDismiss {
                            onDismiss()
                        } else {
                            isPresented.wrappedValue = false
                        }
                    }
                    .transition(.opacity)
            }

            // Sheet Content
            if isPresented.wrappedValue {
                VStack(spacing: 0) {
                    Spacer()

                    VStack(spacing: 0) {
                        // Handle
                        if showHandle {
                            Capsule()
                                .fill(ColorPalette.gray300)
                                .frame(width: 36, height: 4)
                                .padding(.top, Spacing.m)
                                .padding(.bottom, Spacing.s)
                        }

                        // Content
                        content
                            .frame(maxWidth: .infinity)
                            .background(backgroundColor)
                            .cornerRadius(CornerRadius.l, corners: [.topLeft, .topRight])
                            .shadow(color: Shadows.modal.color, radius: Shadows.modal.radius, x: Shadows.modal.x, y: Shadows.modal.y)
                    }
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onChange(of: geometry.frame(in: .global).minY) { newY in
                                    // Auto-dismiss when dragged down significantly
                                    if newY > UIScreen.main.bounds.height * 0.7 {
                                        if let onDismiss = onDismiss {
                                            onDismiss()
                                        } else {
                                            isPresented.wrappedValue = false
                                        }
                                    }
                                }
                        }
                    )
                }
                .transition(.move(edge: .bottom))
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented.wrappedValue)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Sheet Detent
public enum SheetDetent: Equatable {
    case small
    case medium
    case large
    case custom(CGFloat)

    var height: CGFloat {
        switch self {
        case .small:
            return UIScreen.main.bounds.height * 0.25
        case .medium:
            return UIScreen.main.bounds.height * 0.5
        case .large:
            return UIScreen.main.bounds.height * 0.9
        case .custom(let height):
            return height
        }
    }
}

// MARK: - Corner Radius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Convenience Initializers
public extension CustomSheet {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self.init(isPresented: isPresented, content: content)
    }

    init(
        isPresented: Binding<Bool>,
        detent: SheetDetent,
        @ViewBuilder content: () -> Content
    ) {
        self.init(isPresented: isPresented, detents: [detent], content: content)
    }
}

// MARK: - Preview
#Preview {
    @State var isPresented = true

    ZStack {
        ColorPalette.surface
            .ignoresSafeArea()

        Button("Show Sheet") {
            isPresented = true
        }
        .buttonStyle(.plain)

        CustomSheet(isPresented: $isPresented) {
            VStack(spacing: Spacing.l) {
                Text("Custom Sheet")
                    .font(FontStyles.heading2)
                    .foregroundColor(ColorPalette.textPrimary)

                Text("This is a custom bottom sheet with multiple detents and smooth animations.")
                    .font(FontStyles.body)
                    .foregroundColor(ColorPalette.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.screenPadding)

                VStack(spacing: Spacing.m) {
                    TextButton("Action 1", action: {})
                    TextButton("Action 2", action: {})
                    PrimaryButton("Close", action: {
                        isPresented = false
                    })
                }
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.bottom, Spacing.xl)
            }
            .padding(.top, Spacing.l)
        }
    }
}
