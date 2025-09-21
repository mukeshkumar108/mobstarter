# Troubleshooting Guide

Common issues and solutions for MobStarter development. Use this guide to resolve build errors, runtime issues, and development environment problems.

## 🏗️ Build Issues

### "Multiple commands produce..." Error
**Symptoms**: Build fails with "Multiple commands produce..." message
**Solution**:
1. **Clean build folder**: Product → Clean Build Folder (⌘⇧K)
2. **Check target membership**: Ensure files are only in one target
3. **Remove from target**: Select file → File Inspector → Target Membership
4. **Re-add to target**: Check the appropriate target checkbox

### "No such module" Error
**Symptoms**: Xcode can't find imported modules
**Solution**:
1. **Reset package caches**: File → Packages → Reset Package Caches
2. **Resolve packages**: File → Packages → Resolve Package Versions
3. **Clean and rebuild**: Clean build folder, then build again
4. **Check Xcode version**: Ensure Xcode 17.0+ is being used

### "Command PhaseScriptExecution failed" Error
**Symptoms**: Build fails during script execution phase
**Solution**:
1. **Check Xcode version**: Ensure compatibility with iOS 17.0+
2. **Clean derived data**: Delete `~/Library/Developer/Xcode/DerivedData/mobstarter-*`
3. **Restart Xcode**: Sometimes resolves script execution issues
4. **Check system requirements**: Ensure macOS 14.0+ is installed

### "Target Integrity" Error
**Symptoms**: Xcode shows "Target Integrity" issue in project navigator
**Solution**:
1. **Clean build folder**: Product → Clean Build Folder
2. **Close Xcode**: Completely quit and reopen
3. **Delete derived data**: Remove `DerivedData/mobstarter-*` folder
4. **Reopen project**: Open `.xcodeproj` file again

## 🏃 Runtime Issues

### App Crashes on Launch
**Symptoms**: App crashes immediately when launched in simulator
**Solution**:
1. **Check console**: Look for error messages in Xcode console
2. **Add exception breakpoint**: Debug → Breakpoints → Create Exception Breakpoint
3. **Check MainActor usage**: Ensure UI updates are on main thread
4. **Verify @Observable**: Check that state objects are properly marked

### UI Not Updating
**Symptoms**: State changes don't reflect in the UI
**Solution**:
1. **Check @Observable**: Ensure state objects use @Observable
2. **Verify property access**: Use dot notation for property access
3. **Check view hierarchy**: Ensure views are in correct hierarchy
4. **Add debug prints**: Print state values to verify changes

### Authentication Not Persisting
**Symptoms**: User stays logged out after app restart
**Solution**:
1. **Check UserDefaults key**: Verify key name matches in save/load
2. **Test UserDefaults**: Add debug prints to verify save/load
3. **Check state restoration**: Ensure `loadState()` is called in init
4. **Verify logout flow**: Check that logout clears UserDefaults

### Navigation Not Working
**Symptoms**: Taps don't navigate to expected screens
**Solution**:
1. **Check NavigationState**: Verify navigation state is properly passed
2. **Test modal dismissal**: Ensure modals dismiss before navigation
3. **Verify NavigationPath**: Check that path is being modified
4. **Check view hierarchy**: Ensure NavigationStack is properly set up

## 🖥️ Simulator Issues

### Black Screen on Launch
**Symptoms**: Simulator shows black screen instead of app
**Solution**:
1. **Wait longer**: First launch can take 30+ seconds
2. **Reset simulator**: Hardware → Restart
3. **Check console**: Look for error messages
4. **Clean build**: Clean build folder and rebuild

### Touch/Gestures Not Working
**Symptoms**: Taps and gestures don't register in simulator
**Solution**:
1. **Restart simulator**: Hardware → Restart
2. **Reset device**: Device → Erase All Content and Settings
3. **Check mouse settings**: Ensure "Stay on top" is disabled
4. **Try different device**: Switch to iPhone 15 Pro simulator

### Slow Performance
**Symptoms**: App runs slowly in simulator
**Solution**:
1. **Use newer device**: iPhone 15 Pro is faster than older models
2. **Close other apps**: Free up system resources
3. **Increase RAM**: Allocate more RAM to simulator
4. **Check thermal throttling**: Let MacBook cool down

### Keyboard Not Appearing
**Symptoms**: Text fields don't show keyboard when tapped
**Solution**:
1. **Toggle keyboard**: Hardware → Keyboard → Toggle Software Keyboard
2. **Hardware menu**: Hardware → Keyboard → Connect Hardware Keyboard
3. **Restart simulator**: Sometimes resolves keyboard issues
4. **Check text field**: Ensure text field is properly configured

## 📦 Package Management Issues

### "Cannot find package" Error
**Symptoms**: Xcode can't resolve Swift packages
**Solution**:
1. **Check internet**: Ensure stable internet connection
2. **Reset caches**: File → Packages → Reset Package Caches
3. **Update packages**: File → Packages → Update to Latest Package Versions
4. **Check package URL**: Verify repository URL is correct

### Package Resolution Conflicts
**Symptoms**: Xcode shows package resolution conflicts
**Solution**:
1. **Update packages**: File → Packages → Update to Latest
2. **Reset and resolve**: Reset caches, then resolve versions
3. **Check compatibility**: Ensure packages support iOS 17.0+
4. **Clean reinstall**: Delete DerivedData and reset packages

## 🔧 Development Environment Issues

### Xcode Freezing or Slow
**Symptoms**: Xcode becomes unresponsive or very slow
**Solution**:
1. **Restart Xcode**: Complete quit and reopen
2. **Delete derived data**: Remove `~/Library/Developer/Xcode/DerivedData/*`
3. **Free disk space**: Ensure 20GB+ free space
4. **Check system resources**: Monitor CPU/memory usage

### Code Completion Not Working
**Symptoms**: Xcode doesn't provide code suggestions
**Solution**:
1. **Clean build folder**: Product → Clean Build Folder
2. **Re-index project**: Hold ⌘ and click project name
3. **Check syntax errors**: Fix any compilation errors
4. **Restart Xcode**: Sometimes resolves completion issues

### Preview Canvas Not Loading
**Symptoms**: SwiftUI previews don't appear in canvas
**Solution**:
1. **Check preview code**: Ensure #Preview macro is correct
2. **Resume canvas**: Editor → Canvas → Resume
3. **Clean build folder**: Sometimes fixes preview issues
4. **Check device selection**: Ensure preview device is selected

## 🧪 Testing Issues

### Unit Tests Not Running
**Symptoms**: Tests don't execute or show results
**Solution**:
1. **Check test target**: Ensure tests are in correct target
2. **Run specific test**: Product → Test (⌘U)
3. **Check test methods**: Ensure methods start with "test"
4. **Verify imports**: Ensure test files have correct imports

### UI Tests Failing
**Symptoms**: UI tests fail to interact with elements
**Solution**:
1. **Check accessibility**: Ensure elements have accessibility labels
2. **Add delays**: Use sleep() for timing-sensitive interactions
3. **Check element hierarchy**: Verify element identifiers
4. **Test on device**: Sometimes works better than simulator

## 📱 Device-Specific Issues

### App Not Installing on Device
**Symptoms**: App won't install on physical iPhone/iPad
**Solution**:
1. **Check provisioning**: Ensure device is in development team
2. **Trust developer**: Go to Settings → General → VPN & Device Management
3. **Restart device**: Sometimes resolves installation issues
4. **Check certificates**: Verify signing certificates are valid

### Push Notifications Not Working
**Symptoms**: Push notifications don't appear on device
**Solution**:
1. **Check capabilities**: Enable push notifications in project settings
2. **Test with console**: Check console for notification events
3. **Verify token**: Ensure device token is being generated
4. **Check payload**: Verify notification payload format

## 🔍 Debug Techniques

### Console Logging
```swift
// Add debug prints throughout your code
print("🔍 View appeared")
print("📱 User tapped: \(buttonName)")
print("💾 Saving data: \(data)")
print("❌ Error occurred: \(error.localizedDescription)")
```

### Breakpoints and Debugging
1. **Add breakpoint**: Click line number in editor
2. **Conditional breakpoint**: Right-click breakpoint → Edit Breakpoint
3. **Exception breakpoint**: Debug → Breakpoints → Create Exception Breakpoint
4. **Watch variables**: Debug area → Variables View

### View Debugger
1. **Debug View Hierarchy**: Debug → View Debugging → Capture View Hierarchy
2. **Check constraints**: Look for red lines indicating constraint issues
3. **Inspect views**: Click on views to see properties
4. **Check layout**: Verify frames and positioning

## 📞 Getting Help

### When to Ask for Help
- **Build consistently fails** after trying all solutions
- **Runtime crashes** with no clear error messages
- **Feature doesn't work** as expected after debugging
- **Performance issues** that can't be resolved

### Information to Include
1. **Xcode version** and macOS version
2. **Exact error message** (copy from console)
3. **Steps to reproduce** the issue
4. **Expected vs actual behavior**
5. **Recent changes** that might have caused the issue

### Community Resources
- **Apple Developer Forums** - developer.apple.com/forums
- **Stack Overflow** - Tag with [swiftui] [ios] [xcode]
- **Swift Forums** - forums.swift.org
- **GitHub Issues** - Create issue in repository

---

**Remember**: Most issues have been encountered before. Search existing solutions before asking for help.
