# Agent Guide

Guidelines for AI agents working with the MobStarter codebase. This ensures safe, consistent, and effective development practices.

## 🎯 Purpose

This guide helps AI agents:
- **Work safely** with the project structure
- **Follow established patterns** and conventions
- **Avoid common pitfalls** in iOS/SwiftUI development
- **Maintain code quality** and consistency
- **Collaborate effectively** with human developers

## 🚫 Guardrails

### Never Modify Project Files
- **❌ Do NOT edit** `.xcodeproj/project.pbxproj` unless explicitly asked
- **❌ Do NOT edit** `.xcworkspace/contents.xcworkspacedata`
- **❌ Do NOT modify** build settings or configurations
- **❌ Do NOT regenerate** the Xcode project

### Safe File Operations
- **✅ CAN modify** Swift files (`.swift`)
- **✅ CAN modify** documentation (`.md`)
- **✅ CAN create** new files in appropriate directories
- **✅ CAN move** files between directories (preserving target membership)

### Xcode Target Membership
When moving files:
1. **Move the file** in the file system
2. **Re-add to target** in Xcode if needed
3. **Verify build** succeeds after changes
4. **Test functionality** to ensure nothing broke

## 📁 Ownership Map

### Design System (Source of Truth)
```
Utils/Theme.swift
├── ColorPalette (colors, semantic naming)
├── FontStyles (typography hierarchy)
├── Spacing (layout constants)
├── CornerRadius (shape definitions)
└── Shadows (depth and elevation)
```

### Navigation & State Management
```
Models/NavigationState.swift
├── TabItem enum (4 main tabs)
├── SidebarItem enum (6 menu items)
├── NavigationScreen enum (destination mapping)
├── ModalType enum (alerts, confirmations)
└── SheetType enum (filters, sort, share)
```

### App Flow Orchestration
```
Screens/Root/
├── MainAppView.swift (tab bar + sidebar)
├── NavigationDestinationView.swift (screen routing)
└── RootView.swift (top-level state management)
```

### Overlay System
```
Components/Overlays/
├── ModalOverlay.swift (alerts, confirmations)
└── SheetOverlay.swift (filters, sort, share)
```

### Screen Organization
```
Screens/
├── AuthScreen.swift (login/signup)
├── OnboardingScreen.swift (welcome flow)
├── HomeScreen.swift (main dashboard)
├── SearchScreen.swift (search interface)
├── NotificationsScreen.swift (notifications list)
├── ProfileScreen.swift (user profile)
├── SettingsScreen.swift (app settings)
├── HelpScreen.swift (help content)
├── PrivacyPolicyScreen.swift (privacy text)
├── TermsOfServiceScreen.swift (terms text)
└── AboutScreen.swift (app information)
```

### Reusable Components
```
Components/
├── PrimaryButton.swift (main CTA button)
├── TextButton.swift (secondary actions)
├── CustomTextField.swift (form inputs)
├── CardView.swift (content containers)
├── Header.swift (section headers)
├── LoaderView.swift (loading states)
├── CustomTabBar.swift (bottom navigation)
├── SidebarView.swift (side menu)
└── TextKeyValueView.swift (key-value displays)
```

## ✅ Safe Workflows

### Create a Component
1. **Identify component type** (button, input, card, etc.)
2. **Check existing components** in `Components/` directory
3. **Create new file** in appropriate subdirectory
4. **Follow naming convention** (e.g., `CustomButton.swift`)
5. **Use design system** (`ColorPalette`, `FontStyles`, `Spacing`)
6. **Add preview** (`#Preview` macro)
7. **Test in context** (add to a screen temporarily)

### Refactor a Screen
1. **Analyze current screen** (read the entire file)
2. **Identify concerns** (UI logic, business logic, state management)
3. **Extract components** to separate files if needed
4. **Update imports** in affected files
5. **Test navigation** (ensure all buttons/links work)
6. **Verify state management** (no broken @State/@Binding)
7. **Check previews** (all #Preview macros still work)

### Add Dependency
1. **Use Swift Package Manager** (not CocoaPods)
2. **Add via Xcode** (File → Add Packages)
3. **Document in README** (update dependencies section)
4. **Test build** on multiple simulators
5. **Update troubleshooting** if common issues arise

### Fix Build Issues
1. **Clean build folder** (⌘⇧K)
2. **Reset package caches** (File → Packages → Reset)
3. **Check target membership** (ensure files are in correct targets)
4. **Verify imports** (no missing import statements)
5. **Test on device** (simulator vs physical device differences)

## 🧪 Verification Steps

After making changes, always verify:

### Build Verification
```bash
# 1. Clean build
Product → Clean Build Folder

# 2. Build for simulator
Product → Build (⌘B)

# 3. Run on simulator
Product → Run (⌘R)
```

### Functionality Testing
1. **Launch app** → Should show SplashScreen
2. **Complete onboarding** → Should reach AuthScreen
3. **Login** → Should reach MainAppView
4. **Test all 4 tabs** → Home, Search, Notifications, Profile
5. **Open sidebar** → Should show 6 menu items
6. **Test logout** → Should return to AuthScreen
7. **Test modals** → Alert and confirmation dialogs
8. **Test sheets** → Filter, sort, and share overlays

### Console Output Check
Look for these key messages:
- `"🔐 User already logged in"` or `"🔓 User not logged in"`
- `"🚪 User logged out"`
- `"💾 Auth state saved"`

## 📝 Prompts Library

### Add New Screen
```
Create a new screen called "FavoritesScreen" that:
1. Follows the existing screen pattern (one file per screen)
2. Uses the design system (ColorPalette, FontStyles, Spacing)
3. Includes a #Preview macro
4. Has a header with title "Favorites"
5. Contains placeholder content explaining it's a favorites screen
6. Is accessible from the main tab bar or sidebar navigation
```

### Edit Design Token
```
Update the ColorPalette in Utils/Theme.swift to:
1. Add a new semantic color called "brand" with hex value "#3B82F6"
2. Update the accent color to use this new brand color
3. Ensure all existing components still work with the new color
4. Test the change across multiple screens
```

### Fix Target Membership
```
A file was moved and lost its Xcode target membership. To fix:
1. Locate the file in the Project Navigator
2. Check the File Inspector (right panel)
3. Ensure it's added to the "mobstarter" target
4. Verify the build succeeds after adding to target
5. Test the functionality that depends on this file
```

### Refactor Large Component
```
A component file has grown too large and has multiple responsibilities. To refactor:
1. Identify the different concerns (UI layout, business logic, state management)
2. Extract each concern into separate components or view models
3. Update all imports and references
4. Ensure all #Preview macros still work
5. Test all functionality after the refactor
```

### Add New Tab
```
Add a new tab to the main tab bar:
1. Add new case to TabItem enum in Models/NavigationState.swift
2. Add icon properties (filled and outline versions)
3. Create new screen file in Screens/ directory
4. Update MainAppView.swift to include the new tab
5. Test tab selection and navigation
```

## 🤝 Collaboration Guidelines

### Code Review
- **Test changes** in simulator before submitting
- **Check console** for debug output and errors
- **Verify accessibility** (Dynamic Type, VoiceOver)
- **Test on multiple devices** (iPhone SE to iPhone Pro Max)

### Documentation Updates
- **Update README** for new major features
- **Update ARCHITECTURE.md** for structural changes
- **Update COMPONENT_MAP.md** for new files
- **Add troubleshooting** for common issues

### Communication
- **Be specific** about what was changed and why
- **Mention testing** performed (simulator, device, features)
- **Note any breaking changes** or migration steps
- **Include screenshots** for UI changes

---

**Remember**: This is a collaborative project. Every change should make the codebase better for the next developer (human or AI) who works on it.
