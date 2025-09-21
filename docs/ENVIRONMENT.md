# Environment Configuration

Environment setup and configuration management for MobStarter. Learn how to manage different environments and prepare for future integrations.

## 📋 Current Environment Setup

### Development Environment
- **Target**: iOS 17.0+ (simulator and device)
- **Xcode Version**: 17.0+
- **Swift Version**: 5.9+
- **Configuration**: Debug (for development)

### Configuration Files
Currently, MobStarter uses **no external configuration files**. All settings are managed through:

- **Xcode Project Settings** (`.xcodeproj`)
- **Swift Constants** (hardcoded values)
- **UserDefaults** (for user preferences)

## 🔧 App Configuration

### Bundle Identifier
**Location**: Xcode Project Settings → General tab
```
Current: com.mukesh.mobstarter
Change to: com.yourcompany.yourapp
```

### App Name and Display Name
**Location**: Xcode Project Settings → General tab
- **Bundle Name**: `mobstarter` (short name)
- **Display Name**: `MobStarter` (full app name)

### Version Numbers
**Location**: Xcode Project Settings → General tab
- **Current Project Version**: Build number (e.g., `1`)
- **Marketing Version**: App Store version (e.g., `1.0.0`)

### Deployment Target
**Location**: Xcode Project Settings → General tab
```
Minimum Deployments: iOS 17.0
```

## 🔐 Future Supabase Integration

MobStarter is designed to easily integrate with Supabase for backend services. Here's how to prepare:

### Required Environment Variables
```bash
# Supabase Configuration
SUPABASE_URL=your-supabase-url
SUPABASE_ANON_KEY=your-anon-key

# Storage
SUPABASE_STORAGE_BUCKET=avatars

# Authentication
SUPABASE_AUTH_REDIRECT_URL=your-app://auth/callback
```

### Storage Setup
1. **Create Storage Bucket** named `avatars` in Supabase Dashboard
2. **Set bucket policy** to allow authenticated users to upload
3. **Configure CORS** for your domain

### Authentication Setup
1. **Enable providers** in Supabase Auth settings
2. **Configure redirect URLs** for your app scheme
3. **Set up RLS policies** for user data access

## 📱 Adding Configuration Files

### Option 1: xcconfig Files (Recommended)
Create configuration files for different environments:

**Config/Debug.xcconfig**
```xcconfig
APP_NAME = MobStarter
BUNDLE_ID = com.mukesh.mobstarter
API_BASE_URL = http://localhost:3000
ENABLE_DEBUG_MODE = true
```

**Config/Release.xcconfig**
```xcconfig
APP_NAME = MobStarter
BUNDLE_ID = com.mukesh.mobstarter
API_BASE_URL = https://api.mobstarter.com
ENABLE_DEBUG_MODE = false
```

### Option 2: Property List
Create `Config.plist` in the app bundle:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>API_BASE_URL</key>
    <string>https://api.mobstarter.com</string>
    <key>ENABLE_DEBUG_MODE</key>
    <false/>
    <key>MAX_RETRY_ATTEMPTS</key>
    <integer>3</integer>
</dict>
</plist>
```

### Reading Configuration in Code
```swift
// From xcconfig
let apiUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as? String ?? ""

// From plist
if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
   let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
    let apiUrl = dict["API_BASE_URL"] as? String ?? ""
}
```

## 🌍 Environment-Specific Settings

### Debug Configuration
- **Console Logging**: Enabled (print statements visible)
- **Debug Views**: Show wireframes and debug info
- **API Endpoint**: Development/staging server
- **Error Reporting**: Detailed error messages

### Release Configuration
- **Console Logging**: Disabled (no print statements)
- **Debug Views**: Hidden
- **API Endpoint**: Production server
- **Error Reporting**: User-friendly messages only

## 🔄 Build Configurations

### Creating Custom Configurations
1. **Xcode Menu**: Project → Info → Configurations
2. **Add Configuration**: Duplicate existing and rename
3. **Set Settings**: Different values per configuration
4. **Choose Configuration**: Product → Scheme → Edit Scheme

### Configuration Examples

#### Staging Configuration
```xcconfig
APP_NAME = MobStarter (Staging)
BUNDLE_ID = com.mukesh.mobstarter.staging
API_BASE_URL = https://staging-api.mobstarter.com
ENABLE_ANALYTICS = true
ENABLE_DEBUG_MODE = false
```

#### Production Configuration
```xcconfig
APP_NAME = MobStarter
BUNDLE_ID = com.mukesh.mobstarter
API_BASE_URL = https://api.mobstarter.com
ENABLE_ANALYTICS = true
ENABLE_DEBUG_MODE = false
```

## 📦 Environment Variables in Xcode

### Setting Environment Variables
1. **Edit Scheme**: Product → Scheme → Edit Scheme
2. **Environment Variables**: Add key-value pairs
3. **Access in Code**:
```swift
ProcessInfo.processInfo.environment["API_URL"] ?? "default"
```

### Common Environment Variables
```bash
# Development
API_URL=http://localhost:3000
DEBUG_MODE=true
LOG_LEVEL=debug

# Production
API_URL=https://api.mobstarter.com
DEBUG_MODE=false
LOG_LEVEL=error
```

## 🔐 Security Considerations

### Sensitive Data
- **❌ Don't commit** API keys to version control
- **❌ Don't use** hardcoded secrets in code
- **✅ Use** environment variables or secure keychain
- **✅ Use** `.gitignore` for sensitive files

### Secure Storage Options
1. **Keychain Services** (for sensitive user data)
2. **Environment Variables** (for configuration)
3. **xcconfig Files** (for build-time configuration)
4. **Server-side Configuration** (for runtime values)

## 🧪 Testing Environment

### Unit Tests
- **Target**: `mobstarterTests`
- **Configuration**: Test-specific settings
- **Mock Data**: Use test fixtures instead of real data

### UI Tests
- **Target**: `mobstarterUITests`
- **Configuration**: UI test specific settings
- **Test Data**: Isolated test scenarios

## 📱 Device-Specific Configuration

### Simulator Settings
- **Location**: Debug → Location → Custom Location
- **Network**: Fast 3G/Full Signal for consistent testing
- **Appearance**: Test both light and dark modes

### Physical Device Settings
- **Background Modes**: Enable for background tasks
- **Location Services**: Request when in use
- **Notifications**: Enable push notifications

## 🔄 Migration Strategy

### From Current Setup to Supabase
1. **Create Supabase project** and get credentials
2. **Add environment variables** for Supabase config
3. **Update AuthenticationManager** to use Supabase Auth
4. **Replace UserDefaults** with Supabase Database
5. **Update API calls** to use Supabase client
6. **Test thoroughly** in staging environment

### Environment Setup Checklist
- [ ] Create Supabase project
- [ ] Set up environment variables
- [ ] Configure storage bucket
- [ ] Set up authentication providers
- [ ] Test in staging environment
- [ ] Update documentation

## 📚 Resources

- **[Supabase Documentation](https://supabase.com/docs)** - Backend setup
- **[xcconfig Guide](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/XcodeBuildSystem/300-Build_Settings/xcconfig_files.html)** - Configuration files
- **[Environment Variables](https://developer.apple.com/documentation/foundation/processinfo/1415999-environment)** - Runtime configuration

---

**Next Steps**: When ready to add Supabase integration, follow the migration strategy above and update this document with the new configuration details.
