# Component Map

Complete file organization and ownership map for MobStarter. This guide helps developers understand the codebase structure and find relevant files quickly.

## 📁 Project Structure Overview

```
mobstarter/
├── mobstarterApp.swift              # App entry point
├── ContentView.swift                # Root view container
├── RootView.swift                   # Main app orchestration
├── Models/                          # Data models and state management
├── Screens/                         # View screens (one per file)
├── Components/                      # Reusable UI components
├── Utils/                           # Utilities and design system
└── Assets.xcassets/                 # Images and app icons
```

## 🏗️ App Foundation

### Entry Points
- **`mobstarterApp.swift`** - App entry point, defines WindowGroup
- **`ContentView.swift`** - Root view container, calls RootView()
- **`RootView.swift`** - Main app orchestration and state management

### State Management
- **`Models/AppState.swift`** - Application state enum (splash, onboarding, auth, main)
- **`Models/NavigationState.swift`** - Navigation state (tabs, sidebar, modals, sheets)
- **`Models/AuthenticationManager.swift`** - User authentication and persistence

## 🎨 Design System

### Core Design System
- **`Utils/Theme.swift`** - Source of truth for all styling
  - `ColorPalette` - Semantic color system
  - `FontStyles` - Typography hierarchy
  - `Spacing` - Layout constants
  - `CornerRadius` - Shape definitions
  - `Shadows` - Depth and elevation

## 📱 Screens

### Root Composition
- **`Screens/Root/MainAppView.swift`** - Tab bar + sidebar orchestration
- **`Screens/Root/NavigationDestinationView.swift`** - Screen routing and mapping

### Authentication Flow
- **`Screens/AuthScreen.swift`** - Login/signup interface
- **`Screens/OnboardingScreen.swift`** - Welcome flow for new users
- **`Screens/SplashScreen.swift`** - App initialization screen

### Main Application
- **`Screens/HomeScreen.swift`** - Main dashboard
- **`Screens/SearchScreen.swift`** - Search interface
- **`Screens/NotificationsScreen.swift`** - Notifications list
- **`Screens/ProfileScreen.swift`** - User profile

### Settings & Information
- **`Screens/SettingsScreen.swift`** - App settings
- **`Screens/HelpScreen.swift`** - Help content
- **`Screens/PrivacyPolicyScreen.swift`** - Privacy policy text
- **`Screens/TermsOfServiceScreen.swift`** - Terms of service text
- **`Screens/AboutScreen.swift`** - App information

## 🧩 Components

### Core UI Components
- **`Components/PrimaryButton.swift`** - Main call-to-action button
- **`Components/TextButton.swift`** - Secondary action button
- **`Components/CustomTextField.swift`** - Form input fields
- **`Components/CardView.swift`** - Content containers
- **`Components/Header.swift`** - Section headers
- **`Components/LoaderView.swift`** - Loading states

### Navigation Components
- **`Components/CustomTabBar.swift`** - Bottom tab navigation
- **`Components/SidebarView.swift`** - Side menu navigation
- **`Components/TextKeyValueView.swift`** - Key-value displays

### Form Components
- **`Components/CustomSheet.swift`** - Sheet overlay container

### Overlay System
- **`Components/Overlays/ModalOverlay.swift`** - Global modal management
  - Alert modals
  - Confirmation modals
  - Custom modals
- **`Components/Overlays/SheetOverlay.swift`** - Global sheet management
  - Filter sheets
  - Sort sheets
  - Share sheets
  - Custom sheets

## 📊 Models & State

### Application State
- **`Models/AppState.swift`** - App flow state management
  - `.splash` - App initialization
  - `.onboarding` - Welcome flow
  - `.auth` - Authentication screen
  - `.main` - Main application

### Navigation State
- **`Models/NavigationState.swift`** - Navigation management
  - `TabItem` enum - 4 main tabs (home, search, notifications, profile)
  - `SidebarItem` enum - 6 menu items (settings, help, privacy, terms, about, logout)
  - `NavigationScreen` enum - Screen routing
  - `ModalType` enum - Modal types (alert, confirmation, custom)
  - `SheetType` enum - Sheet types (filters, sort, share, custom)

### Authentication
- **`Models/AuthenticationManager.swift`** - User management
  - User struct (id, email, name)
  - Login/logout functionality
  - UserDefaults persistence
  - State restoration

## 🎯 Key Integration Points

### Design System Integration
```swift
// All components use centralized design system
ColorPalette.textPrimary           // Text colors
FontStyles.heading2                // Typography
Spacing.m                         // Layout spacing
CornerRadius.s                    // Border radius
Shadows.card                      // Depth effects
```

### State Management Integration
```swift
// All screens use NavigationState for navigation
@State private var navigationState = NavigationState()

// Authentication state flows through AppState
@State private var appState: AppState = .splash
```

### Component Communication
```swift
// Components communicate via callbacks and state
onLogout: { appState = .auth }     // Navigation callback
confirmAction: { /* perform action */ }  // Modal callback
```

## 🔍 File Ownership

### Design Tokens
- **Owner**: `Utils/Theme.swift`
- **Usage**: All styling decisions flow from here
- **Pattern**: Import and use semantic names

### Navigation Logic
- **Owner**: `Models/NavigationState.swift`
- **Usage**: All navigation state and routing
- **Pattern**: Use enums for type safety

### Screen Content
- **Owner**: Individual screen files in `Screens/`
- **Usage**: One screen per file, focused responsibility
- **Pattern**: Follow screen naming convention

### Reusable UI
- **Owner**: Component files in `Components/`
- **Usage**: Import and use across multiple screens
- **Pattern**: Follow component naming convention

## 📋 Component Usage Patterns

### Creating a New Screen
1. **Create file** in `Screens/` directory
2. **Use design system** (`ColorPalette`, `FontStyles`, `Spacing`)
3. **Add navigation** via `NavigationState`
4. **Include preview** (`#Preview` macro)
5. **Test navigation** from main app

### Creating a New Component
1. **Create file** in appropriate `Components/` subdirectory
2. **Use design system** for consistent styling
3. **Add preview** for visual testing
4. **Test in context** on multiple screens
5. **Document usage** in component comments

### Adding Navigation
1. **Update `NavigationState`** enums if needed
2. **Add screen mapping** in `NavigationDestinationView`
3. **Update navigation triggers** in relevant components
4. **Test all navigation paths**

## 🔗 Cross-References

### Import Patterns
```swift
import SwiftUI
// import Models          // For state management
// import Components      // For UI components
// import Utils           // For design system
```

### Common Dependencies
- **All screens** depend on `NavigationState`
- **All components** depend on `Theme.swift`
- **Auth screens** depend on `AuthenticationManager`
- **Root views** depend on `AppState`

## 📚 Documentation Links

- **[Getting Started](GETTING_STARTED.md)** - Setup and development
- **[Architecture](ARCHITECTURE.md)** - System design details
- **[Agent Guide](AGENT_GUIDE.md)** - AI development guidelines
- **[Style Guide](STYLE_GUIDE.md)** - Coding standards
- **[Troubleshooting](TROUBLESHOOTING.md)** - Common issues

---

**Note**: This map reflects the current state of the codebase. All files follow the single responsibility principle and are organized for maximum maintainability.
