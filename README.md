# MobStarter

A modern SwiftUI iOS boilerplate with a complete design system, authentication flow, and modular architecture. Perfect for starting new iOS projects with best practices built-in.

## ✨ Features

- **🎨 Design System** - Consistent styling with ColorPalette, FontStyles, Spacing, and Shadows
- **📱 Tab Navigation** - 4-tab main interface (Home, Search, Notifications, Profile)
- **🗂️ Sidebar Menu** - Settings, Help, Privacy, Terms, About, and Logout
- **🔲 Modal Overlays** - Alert and confirmation dialogs with backdrop
- **📋 Sheet Overlays** - Filters, sort, and share sheets
- **🔐 Authentication** - Complete auth flow with UserDefaults persistence
- **🎯 Onboarding** - Multi-step onboarding experience
- **📐 Modular Architecture** - Clean separation of concerns
- **♿ Accessibility** - Built-in support for Dynamic Type and screen readers

## 🚀 Quick Start

```bash
git clone git@github.com:mukeshkumar108/mobstarter.git
cd mobstarter
open mobstarter.xcodeproj
```

Select the `mobstarter` scheme and run on iPhone simulator.

[📖 **Getting Started Guide**](docs/GETTING_STARTED.md) | [🏗️ **Architecture**](docs/ARCHITECTURE.md) | [🗺️ **Component Map**](docs/COMPONENT_MAP.md) | [🤖 **Agent Guide**](docs/AGENT_GUIDE.md) | [📝 **Changelog**](CHANGELOG.md)

## 📱 Screenshots

*Add screenshots here showing the main tabs, sidebar, modals, and auth flow*

## 📚 Documentation

- **[Getting Started](docs/GETTING_STARTED.md)** - Setup, build, and run instructions
- **[Architecture](docs/ARCHITECTURE.md)** - System design and component structure
- **[Component Map](docs/COMPONENT_MAP.md)** - File organization and ownership
- **[Agent Guide](docs/AGENT_GUIDE.md)** - Guidelines for AI-assisted development
- **[Style Guide](docs/STYLE_GUIDE.md)** - Swift/SwiftUI coding standards
- **[Environment](docs/ENVIRONMENT.md)** - Configuration and environment setup
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues and solutions
- **[Release Checklist](docs/RELEASE_CHECKLIST.md)** - Deployment and release process

## 🛠️ Development

### Prerequisites
- Xcode 17.0+
- iOS 17.0+ target
- Swift 5.9+

### Project Structure
```
mobstarter/
├── mobstarterApp.swift          # App entry point
├── ContentView.swift            # Root view container
├── RootView.swift               # Main app orchestration
├── Models/                      # Data models and state
├── Screens/                     # View screens (one per file)
├── Components/                  # Reusable UI components
├── Utils/                       # Utilities and design system
└── Assets.xcassets/             # Images and app icons
```

### Design System
All styling is centralized in `Utils/Theme.swift`:
- **Colors**: `ColorPalette` with semantic naming
- **Typography**: `FontStyles` for consistent text sizing
- **Spacing**: `Spacing` constants for consistent layouts
- **Shapes**: `CornerRadius` for consistent border radius
- **Effects**: `Shadows` for depth and elevation

## 🤝 Contributing

1. Follow the [Style Guide](docs/STYLE_GUIDE.md) for code standards
2. Use [Conventional Commits](docs/STYLE_GUIDE.md#commit-style) for commit messages
3. Test on multiple simulators before submitting
4. Update documentation for any new features

## 📄 License

This project is available for use under standard open-source terms.

---

**Built with ❤️ using SwiftUI and modern iOS development practices**
