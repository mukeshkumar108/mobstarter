//
//  SidebarView.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 21/09/2025.
//

import SwiftUI

public struct SidebarView: View {
    @Binding private var isPresented: Bool
    @Binding private var selectedItem: SidebarItem?
    private let items: [SidebarItem]
    private let onItemSelected: ((SidebarItem) -> Void)?
    private let onDismiss: (() -> Void)?

    public init(
        isPresented: Binding<Bool>,
        selectedItem: Binding<SidebarItem?> = .constant(nil),
        items: [SidebarItem] = SidebarItem.allCases,
        onItemSelected: ((SidebarItem) -> Void)? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self._selectedItem = selectedItem
        self.items = items
        self.onItemSelected = onItemSelected
        self.onDismiss = onDismiss
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            // Backdrop
            if isPresented {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        dismiss()
                    }
                    .transition(.opacity)
            }

            // Sidebar Content
            if isPresented {
                HStack(spacing: 0) {
                    // Sidebar
                    VStack(alignment: .leading, spacing: 0) {
                        // Header
                        VStack(alignment: .leading, spacing: Spacing.s) {
                            Text("Menu")
                                .font(FontStyles.heading2)
                                .foregroundColor(ColorPalette.textPrimary)

                            Text("Navigation options")
                                .font(FontStyles.caption)
                                .foregroundColor(ColorPalette.textSecondary)
                        }
                        .padding(.horizontal, Spacing.screenPadding)
                        .padding(.top, Spacing.xl)
                        .padding(.bottom, Spacing.l)

                        // Menu Items
                        VStack(spacing: 0) {
                            ForEach(items) { item in
                                SidebarItemView(
                                    item: item,
                                    isSelected: selectedItem == item,
                                    action: {
                                        selectItem(item)
                                    }
                                )
                            }
                        }

                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .background(ColorPalette.white)
                    .shadow(color: ColorPalette.gray900.opacity(0.2), radius: 8, x: 2, y: 0)

                    Spacer()
                }
                .transition(.move(edge: .leading))
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
            }
        }
        .ignoresSafeArea()
    }

    private func selectItem(_ item: SidebarItem) {
        selectedItem = item
        onItemSelected?(item)
    }

    private func dismiss() {
        isPresented = false
        onDismiss?()
    }
}

// MARK: - Sidebar Item View
private struct SidebarItemView: View {
    let item: SidebarItem
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.m) {
                Image(systemName: item.icon)
                    .font(.system(size: 20, weight: .regular))
                    .frame(width: 24, height: 24)
                    .foregroundColor(isSelected ? ColorPalette.accent : ColorPalette.textSecondary)

                Text(item.rawValue)
                    .font(FontStyles.body)
                    .foregroundColor(isSelected ? ColorPalette.accent : ColorPalette.textPrimary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(ColorPalette.accent)
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
            .padding(.vertical, Spacing.m)
            .background(
                isSelected ?
                ColorPalette.accent.opacity(0.1) :
                Color.clear
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(SidebarButtonStyle())
    }
}

// MARK: - Sidebar Button Style
private struct SidebarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                configuration.isPressed ?
                ColorPalette.gray100 :
                Color.clear
            )
    }
}

// MARK: - Convenience Initializers
public extension SidebarView {
    init(isPresented: Binding<Bool>) {
        self.init(isPresented: isPresented, items: SidebarItem.allCases)
    }

    init(
        isPresented: Binding<Bool>,
        onItemSelected: @escaping (SidebarItem) -> Void
    ) {
        self.init(isPresented: isPresented, items: SidebarItem.allCases, onItemSelected: onItemSelected)
    }
}

// MARK: - Preview
#Preview {
    SidebarView_Previews()
}

private struct SidebarView_Previews: View {
    @State private var isPresented = true
    @State private var selectedItem: SidebarItem? = nil

    var body: some View {
        ZStack {
            ColorPalette.surface
                .ignoresSafeArea()

            Button("Show Sidebar") {
                isPresented = true
            }
            .buttonStyle(.plain)

            SidebarView(
                isPresented: $isPresented,
                selectedItem: $selectedItem,
                onItemSelected: { item in
                    print("Selected: \(item.rawValue)")
                }
            )
        }
    }
}
