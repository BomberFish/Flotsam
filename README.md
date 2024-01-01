# Flotsam

Raise the jetsam priority of a process.

## Usage:

- Build with theos
- Inject dylib however you want to
- Add `com.apple.private.memorystatus` entitlement (this can be done with `ldid` and `required_entitlements.plist`)
- Enjoy iOS not killing your process :trollface: