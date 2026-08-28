# Codex Skills

[简体中文](README.zh-CN.md)

This repository contains four Codex skills for API contract integration, Flutter environment setup on Apple Silicon macOS, behavior-parity migration from UniApp to Flutter, and MasterGo design implementation in UniApp.

Codex can select each skill from its description, or you can invoke one explicitly with `$skill-name`. Explicit invocation is useful when you need to lock the operating mode or edit scope.

## Install

### From a local checkout

List the available skills from the repository root:

```bash
npx skills add . --list
```

Install one skill globally for Codex:

```bash
npx skills add . --skill devops-api-doc-to-code --agent codex -g
```

### From GitHub

List the skills without installing them:

```bash
npx skills add FelixLyfe/codex-skills --list
```

Install one skill:

```bash
npx skills add FelixLyfe/codex-skills \
  --skill migrate-uniapp-to-flutter \
  --agent codex \
  -g
```

Install all four skills:

```bash
npx skills add FelixLyfe/codex-skills \
  --skill '*' \
  --agent codex \
  -g \
  -y
```

The examples use `-g` for a user-level installation. Remove `-g` to install the skills only for the current project.

## devops-api-doc-to-code

Use this skill to extract an API contract from authenticated documentation or supplied text, compare it with a codebase, or implement the required request-to-UI changes.

It has three modes:

- `Extract` produces a normalized contract without reading or changing application code.
- `Audit` compares the contract with the current integration and leaves the worktree unchanged.
- `Implement` performs the audit, applies only the required changes, and verifies the final request path.

Typical inputs include an authenticated documentation URL, an open browser tab, pasted contract text, and the repository that consumes the API. Paste the contract when private documentation is unavailable through browser control.

Example prompts:

```text
Use $devops-api-doc-to-code in Audit mode to compare this API contract with the current code. Report differences without editing files.
```

```text
Use $devops-api-doc-to-code in Implement mode to integrate this contract and trace it through the final HTTP request and UI state.
```

## flutter-macos-env-setup

Use this skill to audit, set up, repair, or validate a Flutter iOS and Android development environment on Apple Silicon macOS. It inspects the machine before changing it, honors repository-pinned FVM, Gradle, Android, and Java constraints, and closes each setup stage with current evidence.

It has three branches:

- `Audit` inventories and diagnoses the environment without changing configuration or repositories.
- `Setup or repair` changes only missing or incompatible components required by the requested workflow.
- `Acceptance` proves the selected toolchain through a disposable demo, pinned project, simulator/emulator, physical device, or Add-to-App host entry.

Results use `PASS`, `WARN`, `SKIP`, and `FAIL`, with simulator/emulator, project build, native host, physical device, and live-service evidence reported separately.

Example prompts:

```text
Use $flutter-macos-env-setup in Audit mode to inspect this Apple Silicon Mac and the current Flutter repository. Report gaps without changing configuration.
```

```text
Use $flutter-macos-env-setup to complete the missing Flutter iOS and Android setup, then prove a disposable demo on an iOS Simulator and Android Emulator and validate the repository with its pinned FVM SDK.
```

## migrate-uniapp-to-flutter

Use this skill to migrate a UniApp/Vue page to Flutter or repair behavior differences in an existing migration. Its scope stays within the selected page and the dependencies required to preserve that page's behavior.

It has three modes:

- `Full migration` moves the complete page behavior, state, API integration, and required platform capabilities.
- `Parity repair` traces and repairs only the affected behavior and dependency closure.
- `Contract-drift audit` compares UniApp, the current API or host contract, and Flutter without changing code.

The skill reports `code`, `build`, `host`, and `live` evidence separately. It adds Mock support only when the task needs offline reproduction, deterministic business states, or an existing Mock/Real boundary.

Example prompts:

```text
Use $migrate-uniapp-to-flutter in Full migration mode to move this UniApp page into the current Flutter repository. Keep the scope to the page and its required dependencies.
```

```text
Use $migrate-uniapp-to-flutter in Contract-drift audit mode to determine whether this field mismatch came from migration or a later contract change. Do not edit code.
```

## mastergo-to-uniapp-ui

Use this skill to implement a MasterGo layer or other design evidence as a UniApp mini-program page or component. It also handles visual and interaction repairs when the runtime result differs from the design.

The skill assigns an authority for layout, copy, assets, interactions, and implementation structure. It reads MasterGo layer data when the integration is available, and can fall back to screenshots, `UI.md`, `icon.md`, or current runtime evidence.

It loads focused references only when the task needs design extraction, layout and routing, selection and forms, keyboard and overlays, or build and runtime validation.

Example prompts:

```text
Use $mastergo-to-uniapp-ui to implement this MasterGo layer in the current UniApp project and compare the runtime result at the same viewport.
```

```text
Use $mastergo-to-uniapp-ui to fix the spacing, text clipping, and popup keyboard behavior shown in this screenshot. Preserve the current business logic.
```

## Repository layout

```text
codex-skills/
├── README.md
├── README.zh-CN.md
├── devops-api-doc-to-code/
├── flutter-macos-env-setup/
├── migrate-uniapp-to-flutter/
└── mastergo-to-uniapp-ui/
```

Each skill directory contains `SKILL.md`, `agents/openai.yaml`, and focused resources such as references or deterministic scripts when the workflow needs them. The installer discovers the repository by scanning these `SKILL.md` files.
