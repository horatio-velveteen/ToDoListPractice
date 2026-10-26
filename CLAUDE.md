# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

A SwiftUI practice to-do list app, currently at the Xcode template stage (`MyApp.swift` entry point → `ContentView`). Single app target, no test target, no Swift packages.

## Building

```sh
# List schemes/destinations
xcodebuild -list -project ToDoListPractice.xcodeproj

# Build for the iOS Simulator
xcodebuild -project ToDoListPractice.xcodeproj -scheme ToDoListPractice \
  -destination 'generic/platform=iOS Simulator' build

# Build for macOS
xcodebuild -project ToDoListPractice.xcodeproj -scheme ToDoListPractice \
  -destination 'platform=macOS' build
```

Before committing, build for both iOS Simulator and macOS.

There are no tests or linters configured yet. If a test target is added, run a single test with `xcodebuild test ... -only-testing:<TestTarget>/<TestClass>/<testMethod>`.

## Project configuration worth knowing

- **Multiplatform target**: supports iOS, macOS, and visionOS (`SUPPORTED_PLATFORMS = iphoneos iphonesimulator macosx xros xrsimulator`, `SDKROOT = auto`). Code must compile on all of them — guard platform-specific APIs with `#if os(...)`.
- **Deployment target 27.0** on iOS/macOS, so the latest SwiftUI/Observation/SwiftData APIs are available without availability checks.
- **File-system-synchronized groups** (`PBXFileSystemSynchronizedRootGroup`, project `objectVersion = 90`): any file placed under `ToDoListPractice/` is automatically part of the target. Do not edit `project.pbxproj` to add source files.
- **Concurrency**: `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` and `SWIFT_APPROACHABLE_CONCURRENCY = YES` — types are main-actor-isolated by default; mark background work explicitly (`nonisolated`, `@concurrent`).
- `SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY = YES`: each file must import the modules whose members it uses (no relying on transitive imports).
- `ContentView.swift` uses `import Playgrounds` with a `#Playground` block for inline experimentation alongside `#Preview`.
- `xcuserdata/` holds per-user Xcode state and shouldn't be committed with code changes.
