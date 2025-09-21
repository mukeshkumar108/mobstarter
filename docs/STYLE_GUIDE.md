# Style Guide

Swift and SwiftUI coding standards for the MobStarter project. Follow these guidelines to maintain consistency and code quality.

## 🏗️ Swift/SwiftUI Style

### Naming Conventions

#### Views and Components
```swift
// ✅ Good - PascalCase for types
struct PrimaryButton: View
struct CustomTextField: View
struct CardView: View

// ✅ Good - descriptive names
struct UserProfileHeader: View
struct NotificationListItem: View
struct SearchResultsContainer: View
```

#### Properties and Methods
```swift
// ✅ Good - camelCase for variables and functions
private var isLoading = false
private var userName = ""
private var errorMessage: String?

func handleUserAction() { }
func validateEmail() -> Bool { }
func updateUserProfile() async { }
```

#### Constants and Enums
```swift
// ✅ Good - PascalCase for enums
enum UserRole {
    case admin, user, guest
}

// ✅ Good - camelCase for cases
enum NavigationDestination {
    case home, settings, profile
}
```

### File Organization

#### Single Responsibility
- **One screen per file** (e.g., `HomeScreen.swift`, `AuthScreen.swift`)
- **One component per file** (e.g., `PrimaryButton.swift`, `CardView.swift`)
- **One model per file** (e.g., `User.swift`, `AppState.swift`)

#### File Structure
```swift
//
//  FileName.swift
//  mobstarter
//
//  Created by Author on Date
//

import SwiftUI

// MARK: - Public Interface
public struct ComponentName: View {
    // Properties
    // Body
}

// MARK: - Private Components
private struct HelperView: View {
    // Implementation
}

// MARK: - Preview
#Preview {
    ComponentName()
}
```

### View Composition

#### Body Structure
```swift
var body: some View {
    VStack(spacing: Spacing.m) {
        // Header section
        Header(title: "Title", subtitle: "Subtitle")

        // Content section
        ScrollView {
            content
        }

        // Action section
        PrimaryButton("Action") {
            handleAction()
        }
    }
    .padding(Spacing.screenPadding)
    .background(ColorPalette.background)
}
```

#### Conditional Views
```swift
// ✅ Good - clear conditional logic
if isLoading {
    LoaderView()
} else if error != nil {
    ErrorView(message: error!)
} else {
    ContentView()
}

// ❌ Avoid - nested conditionals
if condition1 {
    if condition2 {
        ComplexNestedView()
    }
}
```

#### List Views
```swift
// ✅ Good - clear list structure
List(items) { item in
    NavigationLink(destination: DetailView(item: item)) {
        ListItemView(item: item)
    }
}

// ✅ Good - with sections
List {
    Section("Important") {
        ForEach(importantItems) { item in
            ListItemView(item: item)
        }
    }

    Section("Other") {
        ForEach(otherItems) { item in
            ListItemView(item: item)
        }
    }
}
```

## 🎨 Design System Usage

### Colors
```swift
// ✅ Good - use semantic colors
ColorPalette.textPrimary    // Main text
ColorPalette.textSecondary  // Secondary text
ColorPalette.accent         // Interactive elements
ColorPalette.success        // Success states
ColorPalette.error          // Error states
ColorPalette.surface        // Card backgrounds

// ❌ Avoid - hardcoded colors
Color.red                   // Never use
Color(hex: "#FF0000")       // Only for design tokens
```

### Typography
```swift
// ✅ Good - use FontStyles
FontStyles.heading1         // Page titles
FontStyles.heading2         // Section headers
FontStyles.body            // Regular text
FontStyles.bodyLarge       // Important text
FontStyles.caption         // Secondary text
FontStyles.button          // Button text

// ❌ Avoid - system fonts
Font.system(.title)         // Use FontStyles instead
```

### Spacing
```swift
// ✅ Good - use Spacing constants
Spacing.xs                 // 4pt
Spacing.s                  // 8pt
Spacing.m                  // 16pt
Spacing.l                  // 24pt
Spacing.xl                 // 32pt
Spacing.xxl                // 48pt

// ✅ Good - semantic spacing
Spacing.cardPadding        // Card internal padding
Spacing.screenPadding      // Screen edge padding
Spacing.componentSpacing   // Between components

// ❌ Avoid - magic numbers
.someView.padding(20)      // Use Spacing constants
```

### Shapes and Effects
```swift
// ✅ Good - use CornerRadius
CornerRadius.s             // 8pt
CornerRadius.default       // 12pt
CornerRadius.l             // 16pt
CornerRadius.full          // Fully rounded

// ✅ Good - use Shadows
Shadows.card               // Card elevation
Shadows.button             // Button depth
Shadows.modal              // Modal overlay
```

## ♿ Accessibility

### Dynamic Type
```swift
// ✅ Good - support Dynamic Type
Text("Title")
    .font(FontStyles.heading2)

Text("Body text")
    .font(FontStyles.body)

// ❌ Avoid - fixed font sizes
Text("Fixed size")
    .font(.system(size: 16))
```

### Labels and Hints
```swift
// ✅ Good - provide accessibility labels
Button(action: { }) {
    Image(systemName: "trash")
}
.accessibilityLabel("Delete item")
.accessibilityHint("Removes this item permanently")

// ✅ Good - label text fields
TextField("Email", text: $email)
    .accessibilityLabel("Email address")
```

### Color Contrast
```swift
// ✅ Good - ensure sufficient contrast
Text("Important text")
    .foregroundColor(ColorPalette.textPrimary)  // Dark on light
    .background(ColorPalette.white)             // Sufficient contrast

// ❌ Avoid - poor contrast
Text("Low contrast")
    .foregroundColor(ColorPalette.gray400)      // Gray on white
```

## 📱 SwiftUI Best Practices

### State Management
```swift
// ✅ Good - use @State for local state
@State private var isLoading = false
@State private var userInput = ""

// ✅ Good - use @Binding for shared state
func ContentView(isPresented: Binding<Bool>) -> some View

// ✅ Good - use @Observable for complex state
@Observable class ViewModel {
    var items: [Item] = []
    var isLoading = false
}
```

### View Modifiers
```swift
// ✅ Good - chain modifiers clearly
Text("Title")
    .font(FontStyles.heading2)
    .foregroundColor(ColorPalette.textPrimary)
    .multilineTextAlignment(.center)
    .padding(Spacing.m)
    .background(ColorPalette.surface)
    .cornerRadius(CornerRadius.s)

// ❌ Avoid - mixed concerns
Text("Title")
    .font(.title)
    .foregroundColor(.blue)
    .padding()
    .background(Color.white)
```

### Gestures and Interactions
```swift
// ✅ Good - clear gesture handling
Button(action: handleTap) {
    Text("Tap me")
}
.gesture(
    LongPressGesture()
        .onEnded { _ in handleLongPress() }
)

// ✅ Good - drag gestures
.gesture(
    DragGesture()
        .onChanged { value in handleDrag(value) }
        .onEnded { value in handleDragEnd(value) }
)
```

## 📝 Code Organization

### Imports
```swift
import SwiftUI
// import CoreData  // Only if needed
// import Combine   // Only if needed

// Group imports logically
import SwiftUI
import Models
import Components
```

### Extensions
```swift
// ✅ Good - group related extensions
extension View {
    func cardStyle() -> some View {
        self.padding(Spacing.m)
            .background(ColorPalette.surface)
            .cornerRadius(CornerRadius.s)
    }
}

extension Color {
    static let appTheme = ColorPalette.accent
}
```

### Previews
```swift
// ✅ Good - comprehensive preview
#Preview {
    VStack {
        ComponentName()
        ComponentName()
            .disabled(true)
    }
    .padding()
    .background(ColorPalette.background)
}

// ✅ Good - multiple preview scenarios
#Preview("Light Mode") {
    ComponentName()
}

#Preview("Dark Mode") {
    ComponentName()
        .preferredColorScheme(.dark)
}
```

## 🔧 Commit Style

Use [Conventional Commits](https://conventionalcommits.org/) format:

### Commit Types
- **feat**: New feature (e.g., `feat: add user profile screen`)
- **fix**: Bug fix (e.g., `fix: resolve logout navigation issue`)
- **docs**: Documentation (e.g., `docs: update getting started guide`)
- **style**: Code style (e.g., `style: format code with consistent spacing`)
- **refactor**: Code restructuring (e.g., `refactor: extract modal components`)
- **test**: Add tests (e.g., `test: add unit tests for auth manager`)
- **chore**: Maintenance (e.g., `chore: update dependencies`)

### Commit Format
```bash
type(scope): description

[optional body]

[optional footer]
```

### Examples
```bash
# Feature
feat(auth): add biometric authentication support

# Bug fix
fix(logout): ensure modal dismissal before navigation

# Documentation
docs: update architecture guide with new component structure

# Refactor
refactor(overlays): extract modal and sheet components

# Style
style: apply consistent spacing using design system tokens
```

### Scope Guidelines
- **auth**: Authentication-related changes
- **ui**: User interface components
- **nav**: Navigation and routing
- **docs**: Documentation updates
- **config**: Configuration and build settings
- **test**: Testing related changes

## 🚫 Common Mistakes to Avoid

### Anti-Patterns
```swift
// ❌ Avoid - magic numbers
.padding(16)                    // Use Spacing.m
.cornerRadius(8)               // Use CornerRadius.s

// ❌ Avoid - hardcoded colors
.foregroundColor(.blue)        // Use ColorPalette.accent
.background(Color.white)       // Use ColorPalette.background

// ❌ Avoid - mixed concerns
struct LargeView: View {       // Break into smaller components
    var body: some View {
        // 200+ lines of mixed UI and logic
    }
}

// ❌ Avoid - force unwrapping
textField.text!               // Use optional binding or nil coalescing
```

### Performance Issues
```swift
// ❌ Avoid - in body
ForEach(items, id: \.id) { item in
    HeavyComputationView(item: item)  // Move to onAppear or use view model
}

// ✅ Good - computed property
private var computedView: some View {
    // Heavy computation here
}

// ❌ Avoid - multiple rebuilds
@State var toggle = false
Text(toggle ? "A" : "B")      // Use computed property instead
```

### Accessibility Issues
```swift
// ❌ Avoid - missing labels
Button(action: { }) {
    Image(systemName: "star")
}
// Button needs accessibilityLabel

// ✅ Good - proper labels
Button(action: { }) {
    Image(systemName: "star")
}
.accessibilityLabel("Add to favorites")
.accessibilityHint("Saves this item to your favorites list")
```

---

**Remember**: Code is read more often than it's written. Write clear, maintainable code that follows these standards.
