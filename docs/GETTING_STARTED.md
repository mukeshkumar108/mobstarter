# Getting Started

Complete guide to set up, build, and run MobStarter on your development machine.

## 📋 Prerequisites

- **Xcode 17.0+** (download from Mac App Store or [developer.apple.com](https://developer.apple.com))
- **macOS 14.0+** (Sonoma or later)
- **iOS 17.0+** target deployment
- **Swift 5.9+** (included with Xcode 17)

## 🚀 Quick Setup

### 1. Clone the Repository
```bash
git clone git@github.com:mukeshkumar108/mobstarter.git
cd mobstarter
```

### 2. Open in Xcode
```bash
open mobstarter.xcodeproj
```

### 3. Select Scheme and Device
- **Scheme**: `mobstarter` (Product → Scheme → mobstarter)
- **Device**: iPhone 15 Pro (or any iOS 17+ simulator)
- **Configuration**: Debug

### 4. Build and Run
- **⌘R** or **Product → Run**
- Wait for indexing to complete (first time may take several minutes)
- App should launch in iPhone simulator

## 🔧 Development Workflow

### Clear Build Cache (if needed)
```bash
# Remove derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/mobstarter-*

# Clean build folder
Product → Clean Build Folder (⌘⇧K)
```

### Reset Swift Package Manager
```bash
# Delete SPM cache
rm -rf ~/Library/Caches/org.swift.swiftpm

# Reset packages
File → Packages → Reset Package Caches
File → Packages → Resolve Package Versions
```

### Change App Configuration

#### Bundle Identifier
1. **Project Settings** → **General** tab
2. Update **Bundle Identifier** (e.g., `com.yourcompany.mobstarter`)
3. Update **Display Name** and **Version** as needed

#### App Name and Icons
1. **Assets.xcassets** → **AppIcon.appiconset**
2. Replace app icons with your own
3. Update **Display Name** in project settings

## 🧪 Testing Features

### Authentication Flow
1. **Launch app** → Shows SplashScreen
2. **Tap "Continue"** → OnboardingScreen
3. **Complete onboarding** → AuthScreen
4. **Login with any email/password** → MainAppView
5. **Test logout** → Should return to AuthScreen

### Navigation Testing
- **4 Main Tabs**: Home, Search, Notifications, Profile
- **Sidebar Menu**: Settings, Help, Privacy, Terms, About, Logout
- **Modal Testing**: Tap various buttons to trigger alerts/confirmations
- **Sheet Testing**: Use search or filter buttons to open sheets

### Design System Testing
- **Colors**: All UI uses `ColorPalette` from `Utils/Theme.swift`
- **Typography**: Consistent fonts via `FontStyles`
- **Spacing**: Uniform spacing using `Spacing` constants
- **Shadows**: Depth effects via `Shadows`

## 🔐 Authentication Details

### Current Implementation
- **Storage**: UserDefaults (not secure for production)
- **Persistence**: Survives app restarts
- **State Management**: `AuthenticationManager.isLoggedIn`
- **User Model**: Basic struct with id, email, name

### Login Process
1. Enter any email/password (demo accepts all non-empty values)
2. 1.5-second simulated network delay
3. Success creates User object and saves to UserDefaults
4. Navigates to MainAppView

### Logout Process
1. **Sidebar** → **Logout** → **Confirm**
2. Clears `isLoggedIn` and `currentUser`
3. Saves state to UserDefaults
4. Navigates back to AuthScreen

### Testing Logout
```swift
// In simulator, check console for:
"🚪 User logged out"
"💾 Auth state saved: isLoggedIn = false"
```

## 🐛 Troubleshooting

### Build Issues
- **"Multiple commands produce..."**: Clean build folder (⌘⇧K)
- **"No such module"**: Reset package caches (File → Packages → Reset)
- **"Command PhaseScriptExecution failed"**: Check Xcode version compatibility

### Runtime Issues
- **App crashes on launch**: Check console for error messages
- **UI not updating**: Verify @Observable usage in state objects
- **Authentication not persisting**: Check UserDefaults key name

### Simulator Issues
- **Black screen**: Wait for full launch (may take 30+ seconds first time)
- **Touch not working**: Restart simulator (Hardware → Restart)
- **Slow performance**: Use iPhone 15 Pro simulator (newer = faster)

## 📱 Simulator Shortcuts

- **⌘K**: Toggle keyboard
- **⇧⌘H**: Home button
- **Hardware → Rotate**: Test landscape
- **Hardware → Shake Gesture**: Test shake actions
- **Debug → Slow Animations**: Test animations at 25% speed

## 🔄 Development Cycle

1. **Make changes** in Xcode
2. **Build** (⌘B) to check for errors
3. **Run** (⌘R) to test in simulator
4. **Test features** (tabs, sidebar, auth, modals)
5. **Check console** for debug output
6. **Commit changes** with descriptive message

## 📚 Next Steps

- **[Architecture Guide](ARCHITECTURE.md)** - Understand the system design
- **[Component Map](COMPONENT_MAP.md)** - Learn file organization
- **[Style Guide](STYLE_GUIDE.md)** - Follow coding standards
- **[Agent Guide](AGENT_GUIDE.md)** - AI-assisted development guidelines

---

**Need help?** Check the [Troubleshooting Guide](TROUBLESHOOTING.md) or create an issue in the repository.
