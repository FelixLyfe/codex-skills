# Project, runtime, and host validation

Read this reference when the task includes a disposable demo, a Flutter repository, FVM, simulator/emulator or physical-device acceptance, or Add-to-App integration.

## Preserve the baseline

Before project commands, record the repository root, branch/revision, and worktree state. Read the repository's instructions and derive its validation commands from current configuration. Keep pre-existing edits outside the task-owned diff.

Dependency and build commands may create `.dart_tool/`, `.android/`, `.ios/`, `build/`, and other generated output. Respect the repository's ignore policy and do not treat these artifacts as source deliverables. Preserve `pubspec.lock` unless the task actually changes dependencies or the repository's lock policy requires an update.

## Independent demo acceptance

Use a disposable Flutter application outside the business repository to separate base-toolchain failures from product code. Reuse an existing known validation demo only after identifying it; otherwise choose a new empty directory.

```bash
flutter create --platforms=ios,android <demo-name>
cd <demo-name>
flutter analyze
flutter devices
```

For iOS Simulator acceptance:

1. start a stable installed Simulator runtime;
2. select the actual simulator ID from `flutter devices`;
3. run `flutter run -d <device-id>`;
4. observe compilation, installation, launch, and the counter UI;
5. press `r` once and observe Hot Reload before quitting with `q`.

For Android Emulator acceptance, use an ARM64 image and repeat the same build/install/launch/Hot Reload observations. Report iOS and Android separately. A successful demo validates the base toolchain, not a business repository or native host.

## FVM-pinned project acceptance

Read `.fvmrc`, `.metadata`, README, CI, and relevant platform build files before running commands. Confirm the project SDK resolves through `.fvm/flutter_sdk` and that the Dart executable is `arm64` on Apple Silicon.

Use repository-prescribed commands. A common Flutter module ladder is:

```bash
fvm flutter pub get
fvm dart format --output=none --set-exit-if-changed <repository-defined-paths>
fvm flutter analyze
fvm flutter test
fvm flutter build bundle --release <repository-required-defines>
```

Do not substitute global `flutter` or `dart` after a pinned command fails. Diagnose FVM cache permissions, project constraints, dependency sources, or the actual command failure and retry the same project SDK.

Record each command, exit status, SDK version, and relevant test count/output separately. A historical test count or prior release build is context, not current evidence.

## Add-to-App acceptance

A module build proves Dart/Flutter compilation only. Host acceptance requires the actual native entry, engine lifecycle, route input, host contracts, and attach flow.

### Host discovery gate

Before launching an IDE or build, locate and record:

- Android host root, Gradle Wrapper, application module, native Flutter entry, and module integration path;
- iOS host root, `.xcworkspace` or `.xcodeproj`, scheme, native Flutter entry, and module integration path;
- the user action and route/input that open the target Flutter page on each requested platform.

A README statement that hosts exist elsewhere is not a resolved path. When a requested host item cannot be located, close that platform as `FAIL` at the missing path/entry boundary, or `SKIP` only when the platform is outside scope. Continue with module evidence separately; do not enter host-build or attach steps.

### Android host

1. Open the Android host in Android Studio and finish Gradle Sync.
2. Resolve a missing Run Configuration by creating the repository-appropriate Android App configuration for the host module.
3. Select the target device and Debug build variant.
4. Debug the native app and navigate through the real entry that creates the Flutter engine/page.

Classify a non-blocking Kotlin/AGP deprecation warning as `WARN` when sync and Debug build succeed. Upgrade build tooling only when the requested scope or demonstrated compatibility failure requires it.

### iOS host

1. Open the host `.xcworkspace` when it uses CocoaPods, otherwise the applicable `.xcodeproj`.
2. Select the host scheme, Debug configuration, and target device.
3. Run the native app and enter the Flutter page while its engine remains alive.

### Attach and Hot Reload

From the module root, use the repository-pinned SDK:

```bash
fvm flutter devices
fvm flutter attach -d <device-id>
```

After attach succeeds, change a harmless Dart-visible value or use the existing validation action and trigger Hot Reload. Dart changes can reload; Kotlin, Java, Swift, Objective-C, Gradle, Pod, and native lifecycle changes require a native rebuild.

Record host platform, host revision, build mode, device, native entry, route input, attach result, and Hot Reload result. Host Debug build without entering the page or attaching is incomplete host evidence.

## Physical devices

Physical-device acceptance is optional only when no suitable device is available or it is outside scope. Mark it `SKIP` with the reason rather than `PASS`.

For iOS, record USB/trust state, Developer Mode, selected signing team, bundle identifier ownership, compile/install/launch, and Hot Reload. Change signing only inside a disposable demo or explicitly owned host target.

For Android, require `adb devices` to show `device`, not `unauthorized` or `offline`, then record compile/install/launch and Hot Reload. Complete USB authorization before treating wireless debugging as relevant.

## Evidence boundaries

Keep these claims independent:

- **toolchain:** paths, versions, architecture, licenses, and doctor checks;
- **code:** formatting, analysis, and tests;
- **build:** Flutter output or native host compiled;
- **simulator/emulator:** the app installed, launched, and reloaded on the named virtual device;
- **host:** the native app opened the actual Flutter page and attach succeeded;
- **physical device:** the named real device installed and ran the app;
- **live service:** authenticated requests or backend-controlled behavior were observed.

One level cannot be used as proof for a later level.
