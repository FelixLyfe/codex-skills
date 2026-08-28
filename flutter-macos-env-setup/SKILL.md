---
name: flutter-macos-env-setup
description: Stage-gated setup, audit, repair, and validation of Flutter iOS/Android tooling on Apple Silicon macOS. Use for clean-machine setup, toolchain repair, FVM project checks, simulator/device acceptance, or Add-to-App host debugging.
---

# Flutter macOS Environment Setup

Treat the task as a **stage-gated setup**: observe the machine first, change only the gaps in scope, and close each gate with current evidence before advancing. The target is a maintainable Apple Silicon toolchain, not a mechanically green `flutter doctor`.

## Select the branch

- **Audit:** inventory the environment, diagnose gaps, and keep configuration and repositories unchanged. A request to inspect, assess, or diagnose selects this branch unless it also asks for repair.
- **Setup or repair:** install or configure only the missing or incompatible components required by the requested iOS, Android, project, or host workflow.
- **Acceptance:** exercise an existing environment through the requested demo, project, simulator, emulator, physical device, or Add-to-App entry. Keep configuration unchanged unless the user also requests repair.

A complete clean-machine setup includes independent iOS Simulator and Android Emulator acceptance unless the user narrows the scope. Physical-device checks require an available device; Add-to-App acceptance applies only when a native host is in scope.

## Authority and evidence

Use this order when facts disagree:

1. the user's requested scope and named target;
2. applicable repository instructions and pinned files such as `.fvmrc`, Gradle Wrapper, AGP/Kotlin configuration, CI, and host project settings;
3. observed paths, versions, architecture, commands, and runtime behavior from the current machine;
4. current official Apple, Flutter, Android, Gradle, and Homebrew documentation;
5. examples in this skill.

Recheck current stable versions, compatibility, download architecture, and platform requirements rather than carrying dated examples forward. Keep global Flutter Stable and a repository-pinned FVM SDK as separate roles; one does not prove or replace the other.

Record results with these meanings:

- `PASS`: the named check or runtime path succeeded in this run.
- `WARN`: the check completed with a non-blocking issue whose impact is stated.
- `SKIP`: the check was out of scope, inapplicable, unavailable, or not authorized; state why.
- `FAIL`: a required attempted gate failed; state the first failing boundary and its impact.

## Load only the needed detail

- Run [`scripts/preflight.sh`](scripts/preflight.sh) at the start when local shell access is available. Pass the target repository as its optional argument when a project is in scope. The script inventories state; it does not install, upgrade, delete, or edit configuration.
- Read [references/toolchain-setup.md](references/toolchain-setup.md) before auditing version compatibility or installing, selecting, or repairing Xcode, Homebrew, Flutter, FVM, Android Studio/SDK, Java, CocoaPods, Rosetta, shell configuration, or mirrors.
- Read [references/project-and-host-validation.md](references/project-and-host-validation.md) when a demo, FVM repository, simulator/emulator, physical device, or Add-to-App host is in scope.
- Read [references/reporting.md](references/reporting.md) before final acceptance reporting; include only rows applicable to the selected branch.

## Stage gates

### 1. Establish the boundary

Read the request and applicable repository instructions. Identify the selected branch, target Mac, required platforms, target repository, native hosts, requested devices, and whether installation or configuration changes are authorized. If the request names a document, treat its commands as source material until the request explicitly authorizes execution.

Capture the baseline worktree before any repository-scoped validation. Preserve unrelated changes and generated artifacts already present.

**Complete when:** branch, owned paths, platform/host/device scope, authority files, permitted mutations, and pre-existing worktree state are explicit.

### 2. Inventory before changing

Run the preflight script when available, then verify material unknowns directly. For a target repository, read its `.fvmrc`, `.metadata`, README, CI configuration, Gradle Wrapper, AGP/Kotlin declarations, iOS dependency setup, and host topology before choosing versions or commands.

Classify each in-scope component as `keep`, `configure`, `install`, `repair`, or `unknown`. Separate absent software from a broken PATH, wrong architecture, incompatible version, missing license, unavailable runtime image, and repository-specific incompatibility.

**Complete when:** every in-scope component has an observed path/version/architecture or a named unknown, and every project toolchain constraint has an identified authority.

### 3. Define the gates

Read the relevant setup reference. Map each proposed mutation to one observed gap and one immediate verification command. Order only the required gates: machine prerequisites, Apple toolchain, global Flutter/FVM, Android toolchain/Java, optional compatibility tools, then runtime acceptance.

Before a `sudo` command, system upgrade, license acceptance, shell-profile replacement, SDK deletion, or destructive reinstall, explain the exact need and obtain the required approval. Prefer additive, idempotent configuration and official Stable Apple Silicon distributions.

**Complete when:** every planned change has a scoped reason, verification command, rollback or preservation story where relevant, and approval point where required.

### 4. Audit or close each setup gap

In Audit mode, finalize the classified gaps without mutation, run only the non-mutating checks required by the audit, then continue to the closing report. In Setup or repair mode, perform one gate at a time and verify it before advancing. Reuse correctly installed components; preserve existing shell content while applying the smallest non-duplicated environment change.

On failure, keep the gate open, identify the first failing boundary, and repair that cause before retrying. Avoid stacking alternative SDKs, JDKs, mirrors, or PATH entries as an error workaround.

**Complete when:** every requested component is either verified at its required path/version/architecture or has a `FAIL`/`SKIP` result tied to the exact unresolved boundary.

### 5. Prove the base toolchain

In Audit mode, classify diagnostic side effects before execution. Flutter/FVM commands can initialize or update SDK caches, `adb` can start a daemon and write logs, and `simctl` can contact or start simulator services. Run these checks only with authorization for those effects or against an isolated writable copy; otherwise record `SKIP` and the evidence still needed.

In Setup or repair and Acceptance modes, run the applicable global and FVM `flutter doctor -v` checks. For a complete setup or explicit runtime acceptance, create or reuse a clearly identified disposable Flutter demo outside the business repository and run it on one iOS Simulator and one ARM Android Emulator. Trigger one Hot Reload in each interactive run.

Treat network-resource, unused editor, and disconnected-device notices according to their actual impact. A doctor warning cannot replace a failed build, and a green doctor cannot replace runtime acceptance.

**Complete when:** each required doctor, build, install, launch, and Hot Reload action has its own result and named SDK, device, and build mode.

### 6. Prove the project and host branches

When a repository is in scope, read the project/host reference and use its pinned SDK and repository-prescribed commands. Report dependency resolution, format check, analysis, tests, and relevant release build separately.

For Add-to-App, close the host-discovery gate in the project/host reference before opening an IDE or building. Then validate the requested native Android and/or iOS host in Debug, enter the actual Flutter page, and attach from the module. Module-only execution proves neither host contracts nor native lifecycle integration. Physical devices are separate evidence from simulators and emulators.

After validation, compare the worktree with the baseline. Keep generated directories and temporary credentials out of the owned diff.

**Complete when:** every in-scope project, host, attach, and device row has current evidence or an explicit `SKIP`/`FAIL` reason, and no validation artifact is mistaken for a source change.

### 7. Close the report

Use the reporting reference. Lead with separate execution and target-readiness results plus the highest evidence level, then list component paths/versions, changes made, gate results, warnings/failures, and exact remaining actions. Distinguish code, build, simulator/emulator, native-host, physical-device, and live-service evidence.

Claim only what this run observed. A document review, installed SDK, compiled module, Debug host build, and physical-device render are different evidence levels.

**Complete when:** every requested outcome maps to a reported evidence row, every non-PASS row states impact and next action, and the final worktree scope is accounted for.
