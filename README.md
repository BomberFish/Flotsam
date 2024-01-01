# Flotsam

Make iOS not kill your process.

## Usage:

- Build with theos
- Inject dylib however you want to
- Add `com.apple.private.memorystatus` entitlement (this can be done with `ldid` and `required_entitlements.plist`)
- Enjoy iOS not killing your process :trollface:

## Wanna add this to your app?

Just copy the contents of `flotsam.m`. It's that simple*
> *You actually need to do a little more work. Put the logic from the file in another function, and grab kern_memorystatus.h. I am not responsible for any Apple hitmen visiting your house.