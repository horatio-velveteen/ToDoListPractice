# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

A SwiftUI practice to-do list app (a learning project). Single app target, no test target, no Swift packages.

## Architecture and roadmap

- MVVM layout under `ToDoListPractice/`: `Models/` (`TodoItem` plus sample data via `TodoItem.createList()`), `ViewModels/` (`@Observable` view models that own state), `Views/`. A `Storage/` folder (a `TaskStore` protocol backed by JSON in the Documents directory) is planned but doesn't exist yet.
- `MyApp.swift` owns the `TodoListViewModel` and launches `TodoListView`. The template `ContentView` is no longer the root.
- `github-issues.md` is the build plan: 13 issues done in order, each with acceptance criteria and "Depends on" links. Commits/PRs follow one issue at a time and reference the GitHub issue number (e.g. "Add TodoItem model and sample data (#14)"). Before working on a feature, check its acceptance criteria there. The plan expects views to hold no task data themselves (they display view-model state and report taps), editing to happen on a draft copy, and deletion to go by `id`, not index.
- Because this is a practice project, the user may want hints or explanations instead of finished code. Ask if it's unclear which one they want.
- `LEARN_LOG.md` is the user's daily learn log (newest first). After finishing a task (e.g. a merged PR or closed issue), offer to update it; don't update it without a yes. When updating, add or extend today's dated entry with "What changed" (from git log/diff and the session) and "What I learned" (concepts explained or mistakes fixed).
- When pointing out a problem or something that should change, always give the file and line as `path/to/File.swift:line` (or a range like `:9-14`). If the issue is that something is missing, give the line where it belongs and the line of the requirement it fails (e.g. in `github-issues.md`).

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
- **Deployment target 27.0** on iOS/macOS/visionOS, so the latest SwiftUI/Observation/SwiftData APIs are available without availability checks.
- **File-system-synchronized groups** (`PBXFileSystemSynchronizedRootGroup`, project `objectVersion = 90`): any file placed under `ToDoListPractice/` is automatically part of the target. Do not edit `project.pbxproj` to add source files.
- **Concurrency**: `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` and `SWIFT_APPROACHABLE_CONCURRENCY = YES` — types are main-actor-isolated by default; mark background work explicitly (`nonisolated`, `@concurrent`).
- `SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY = YES`: each file must import the modules whose members it uses (no relying on transitive imports).
- `ContentView.swift` uses `import Playgrounds` with a `#Playground` block for inline experimentation alongside `#Preview`.
- `xcuserdata/` holds per-user Xcode state and shouldn't be committed with code changes.
