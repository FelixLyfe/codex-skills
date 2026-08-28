# Toolchain setup and repair

Read this reference when the task audits toolchain compatibility or may install, select, configure, or repair a component. Commands are patterns: first resolve exact versions and paths from repository constraints, observed machine state, and current official documentation.

## Current-fact boundary

Verify time-sensitive facts from primary sources before acting:

- [Apple Xcode system requirements](https://developer.apple.com/support/xcode/)
- [Flutter install on macOS](https://docs.flutter.dev/get-started/install/macos)
- [Flutter SDK archive](https://docs.flutter.dev/install/archive)
- [Flutter Android setup](https://docs.flutter.dev/platform-integration/android/setup)
- [Homebrew](https://brew.sh/)
- [Gradle Java compatibility](https://docs.gradle.org/current/userguide/compatibility.html)

Use repository declarations for project-pinned Flutter, Dart, Gradle, AGP, Kotlin, compile SDK, NDK, CMake, and Java requirements. A version observed in another project is evidence for that project only.

## Gate A: machine prerequisites

Capture at least:

```bash
uname -m
sw_vers -productVersion
printf '%s\n' "$SHELL"
df -h /
```

The target architecture is `arm64`. Resolve an unexpected architecture before installing SDKs. Confirm sufficient disk space for Xcode, simulator runtimes, Android Studio, Android SDK packages, and emulator images.

For a full clean-machine setup, Rosetta 2 is a compatibility component for legacy x86_64 tools. Its absence is a warning when no required dependency needs it; install it only inside the authorized setup scope:

```bash
sudo softwareupdate --install-rosetta --agree-to-license
```

System upgrades and Rosetta license acceptance are approval boundaries.

## Gate B: Xcode and iOS tooling

Use the current stable Xcode supported by the installed macOS. Keep the canonical application at `/Applications/Xcode.app`, then select and initialize it:

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
xcode-select -p
xcodebuild -version
```

Accept licenses through the supported Xcode flow and install only the iOS SDK/runtime needed for the selected target. A Command Line Tools path alone does not supply the full simulator/build toolchain. Close this gate only when `xcode-select -p` resolves inside the intended Xcode and `xcodebuild -version` succeeds.

## Gate C: Homebrew and shell profile

On Apple Silicon, the expected Homebrew prefix is `/opt/homebrew`. Reuse an existing installation when its path and architecture are correct. Install from the official Homebrew source only when absent.

Keep shell initialization idempotent. Inspect the active zsh startup files before editing; preserve user content and update one existing equivalent entry instead of appending duplicates. A typical Homebrew initialization is:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Verify with:

```bash
command -v brew
brew --version
brew doctor
```

Treat non-blocking `brew doctor` warnings as `WARN` with impact, rather than changing system directories merely to make the output clean.

## Gate D: global Flutter and project FVM

Use the official Stable Apple Silicon Flutter archive for the global SDK. Unless the user or workspace has another established convention, place it at `~/develop/flutter`. Inspect an existing directory before replacement.

Configure exactly one global Flutter PATH entry in the active zsh profile:

```bash
export PATH="$HOME/develop/flutter/bin:$PATH"
```

Verify the resolved executable and architecture:

```bash
command -v flutter
flutter --version
dart --version
file "$HOME/develop/flutter/bin/cache/dart-sdk/bin/dart"
```

Run `flutter channel stable` or `flutter upgrade` only for the global SDK and only when the requested scope includes upgrading it. A project with `.fvmrc` keeps its declared version.

Install FVM from the active global Dart when needed:

```bash
dart pub global activate fvm
```

Expose the pub global executable directory once:

```bash
export PATH="$HOME/.pub-cache/bin:$PATH"
```

Inside a pinned repository, use `fvm flutter` and `fvm dart`. Keep `.fvmrc` under version control when that is the repository convention and keep the local `.fvm/` cache/symlink directory ignored. Global Stable and FVM versions may coexist because their responsibilities differ.

## Gate E: Android Studio and Android SDK

Install the Apple Silicon Android Studio build. Use its Setup Wizard and SDK Manager to install only the packages required by current Flutter guidance and the target repository, normally including:

- Android SDK Platform required by `compileSdk`;
- Build-Tools;
- Platform-Tools;
- Command-line Tools;
- Android Emulator;
- required CMake and NDK side-by-side versions.

The conventional SDK location is `~/Library/Android/sdk`. Preserve a working custom location; otherwise configure one coherent SDK root and PATH:

```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
```

Verify paths and installed packages:

```bash
printf '%s\n' "$ANDROID_HOME"
command -v adb
adb --version
command -v sdkmanager
sdkmanager --version
sdkmanager --list_installed
```

Accept Android licenses with the Flutter SDK that owns the project command:

```bash
flutter doctor --android-licenses
# or, in a pinned repository
fvm flutter doctor --android-licenses
```

License acceptance is an explicit user interaction. Select ARM64 emulator images for normal Apple Silicon development; use x86_64 only for a named compatibility investigation and report its tradeoff.

## Gate F: Java selection

Start with the JBR bundled with Android Studio. Evaluate Java against the target repository's Gradle Wrapper, AGP, and Kotlin versions, not against Android Studio startup alone.

Configure an external JDK only when the repository compatibility evidence requires it. Select one project JDK, set `JAVA_HOME` to that exact installation if needed, and point Flutter at the same directory when appropriate:

```bash
fvm flutter config --jdk-dir="/absolute/path/to/compatible/jdk/Contents/Home"
java -version
fvm flutter doctor -v
```

Installing JDK 17 is a project-dependent compatibility choice, not a universal default. Existing unused JDKs can remain until their ownership is known; the active project path must be unambiguous.

## Gate G: compatibility and editor tools

Install CocoaPods when an existing iOS host or plugin graph requires it. Prefer the Homebrew-managed package on Apple Silicon and verify `pod --version`; keep macOS system Ruby untouched.

Configure Flutter/Dart editor extensions only for editors in scope. For an FVM repository, point the editor to `<repo>/.fvm/flutter_sdk`, not the global SDK.

Configure Flutter package/storage mirrors only when the repository already requires them or repeated, independently confirmed TLS/source access failures justify the change. Use the project's documented endpoints or current Flutter guidance. Verify dependency resolution after the change; preserve system certificates and SDK installations while diagnosing a single source check.

## Failure routing

- **Only Command Line Tools present:** install/select full Xcode; simulator and `xcodebuild` acceptance remain open.
- **Java/Gradle incompatibility:** read wrapper and AGP/Kotlin constraints, select one compatible JDK, then rerun the same failing command.
- **Android package missing:** install the exact required platform/tool version through SDK Manager, then verify `sdkmanager --list_installed`.
- **Doctor network warning:** test the named URL independently, retry, then apply a repository-approved mirror only if the failure is reproducible.
- **Doctor is green but build fails:** diagnose the build boundary; doctor status is not build evidence.
- **Installed component is correct but unresolved:** repair PATH/selection first; reinstall only when installation integrity is the demonstrated cause.
