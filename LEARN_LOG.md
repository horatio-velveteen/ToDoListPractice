# Learn Log

What changed each day and what I learned along the way. Newest first.

---

## 2026-10-29: Add task sheet (Issue 6)

**Branch:** `issue-6-add-task-sheet` (changes not committed yet)
**Issues touched:** #6 Add task sheet

### What changed
- **New `ViewModels/TaskEditorViewModel.swift`:** holds the draft `title`, `notes` and `dueDate`. `canSave` is false when the trimmed title is empty, and `makeItem()` builds a `TodoItem` with the trimmed title.
- **New `Views/AddTaskSheet.swift`:** a form with Title and Notes fields, plus Cancel and Save buttons. Save is `.disabled(!viewModel.canSave)`. Focus is set in `.task` so the keyboard opens when the sheet appears.
- **`TodoListViewModel.add(_:)`** inserts the new task at the top of the list.
- **`TodoListView`:** the "+" button sets `isAddingTask`, and a `.sheet` shows `AddTaskSheet` and calls `viewModel.add` on save.
- Renamed `index` to `selectedTask` in `toggleCompletion(id:)`.
- Built for iOS Simulator and macOS. Not yet checked by hand in the simulator.

### What I learned
- **Edit a draft, not the real data.** The sheet works on its own `TaskEditorViewModel` and only hands back a finished `TodoItem` through the `onSave` closure. Cancel never calls it, so nothing is added.
- **Callbacks go from parent to child.** `AddTaskSheet` doesn't know about `TodoListViewModel`; the parent passes in `onSave`.
- **`@State` on the sheet gives a fresh draft each time.** The sheet is rebuilt on every presentation, so a cancelled draft doesn't carry over.
- **Trim with `.whitespacesAndNewlines`** so a title of only spaces or newlines counts as empty, and trim again when saving so "  Buy milk " is stored as "Buy milk".
- **`@FocusState` + `.task`** opens the keyboard automatically. If `.onAppear` is ignored inside a sheet, `.task` is the fallback.
- **One `@FocusState` Bool on two fields:** the Title and Notes fields share `isFieldFocused`, so the same Bool is true when either is focused and tells you nothing about which one. An enum-based `@FocusState` tracks them separately.

---

## 2026-10-29: Closing out Issue 5 (toggle complete)

**Branch:** `issue-3-task-list` (changes not committed yet)
**Issues touched:** #5 Toggle task complete / incomplete

### What changed
- Checked the toggle from Issue 5 and found it was already built in `bb12d7c`. Only the last two acceptance criteria were unverified.
- **`isCompleted` is now computed** (`var isCompleted: Bool { completedAt != nil }` in `Models/TodoItem.swift`). This is the second fix the ticket suggested for the PR #14 review note. It removes the stored `isCompleted` and the `isCompleted:` argument from the four sample items in `createList()`.
- `toggleCompletion(id:)` now only sets `completedAt` (`nil` if it was completed, `Date()` if not).
- Ticked all four acceptance boxes on issue #5 on GitHub.

### What I learned
- **Two fields that describe one fact can disagree.** `isCompleted` and `completedAt` could say different things. Keeping only `completedAt` and deriving `isCompleted` from it makes a contradiction impossible.
- **Computed properties are not stored or encoded.** `isCompleted` no longer appears in the memberwise init, and `Codable` skips it. Anything that already saved an `isCompleted` value would need migrating.
- **Check "already done" before building.** Reading the code first showed most of the ticket was finished.
- **Test logic without the UI.** Compiling the model and view model with `swiftc` and a tiny `main.swift` printed state after each toggle, with no simulator.
- `CLAUDE.md` still says `MyApp.swift` launches `ContentView`, but it now launches `TodoListView`.

---

## 2026-10-27: Task list screen, header, and completing tasks

**Branch:** `issue-3-task-list` (commits `8070c22`, `bb12d7c`, `7a16c37`)
**Issues touched:** #3 Task list screen, #4 View model, #5 Toggle complete

### What changed
- **New header view** (`Views/TaskViewHeader.swift`): avatar, filter/sort/more buttons, a "Find tasks" search bar with a blue border when focused, and a plain "My tasks" label (on purpose, not a tab bar). First called `TaskHomeView`, renamed because it's only the top of the page.
- **Header sits above the list** in `TodoListView`. Search text lives in `TodoListView` and the header gets it through `@Binding`.
- **Completing tasks** (Issue 5): `toggleCompletion(id:)` in `TodoListViewModel` flips `isCompleted` and sets/clears `completedAt`. The tap goes row → list → `TodoListView` → view model.
- **Rest of the page, based on the Evernote reference** ([Mobbin](https://mobbin.com/screens/e5da9609-b2d9-4a47-a401-672f628345b5)):
  - collapsible "Your Tasks (n)" and "Completed (n)" groups using a reusable `TaskGroupHeader`
  - rows with a purple checkbox, notes and "Due Nov 7 at 1:00 AM"
  - completed rows greyed and struck through
  - a purple floating add button, not hooked up yet (Issue 6)
- Fixed the `"flage.fill"` → `"flag.fill"` SF Symbol typo.
- Changed the header label from "My tasks" to "Tasks", which matches Issue 3's "title says Tasks" criterion.
- Started this learn log, and added a `CLAUDE.md` rule: after finishing a task, Claude offers to update the log (it doesn't write to it without a yes).

### What I learned
- **`@State` vs `@Binding`:** state belongs to the view that *owns* it. When a child (the header) needs to change something the parent's other children (the list) react to, keep the `@State` in the parent and pass a `$binding` down.
- **`@FocusState`** tells a view whether a text field is focused. That's how the search border turns blue.
- **Views report, view models change:** a child view takes a closure like `onToggle: (TodoItem.ID) -> Void` and calls it. It never changes the data itself. Then `@Observable` redraws the screen when the view model's data changes.
- **Find items by `id`, not by index:** once the list is filtered by search, row 2 on screen isn't `todoList[2]`. `firstIndex(where: { $0.id == id })` always finds the right task.
- **Computed properties for filtering** (`visibleTasks`, `activeTasks`, `completedTasks`) change what's shown without touching stored data.
- **Name views for what they are:** a view that also draws rows isn't a "header". Splitting it made each piece reusable (`TaskGroupHeader` is used twice).
- A misspelled SF Symbol name still compiles. It just shows nothing at runtime.
- Plan mode: map out the data flow and the files/lines to change *before* coding.
- **Claude Code sessions:** a session is one conversation, and a new one starts without the previous conversation.
  - **What carries over:** files, git history, `CLAUDE.md` (read automatically every session) and saved memories.
  - **Picking an old conversation back up:** `claude --continue` reopens the latest one, and `claude --resume` lets you pick one.
  - Anything worth keeping should be written to a file.
- **`CLAUDE.md` is read from the branch you're on.** Commit it, or switching branches can hide the new instructions.
- **Log learnings before ending a session.** "What changed" can be rebuilt from git, but "what I learned" only exists in the conversation.
- **When a skill is worth making:** for a long, repeatable procedure. A short rule fits better as a line in `CLAUDE.md`.

---

## 2026-10-26: Finishing Issue 2 properly

**PR:** #15, squash-merged into `main` as `0c08e72`

### What changed
- Added the missing `createdAt: Date` to `TodoItem`, which Issue 2's acceptance criteria required.
- Removed `static` from `TodoListViewModel.todoList`.
- Updated `CLAUDE.md` with the architecture/roadmap and a rule to always point to problems as `file:line`.

### What I learned
- **`@Observable` only tracks instance properties.** A `static var` won't update the screen.
- **Default values** (`var createdAt = Date()`) make an argument optional in the memberwise init.
- **Sample data should be consistent:** a task can't be completed (10/25) before it was created. `Date()` in sample data means "app launch time", so use fixed dates.
- `stringToDate` returns `Date?`, so `?? Date()` is needed to fill a non-optional `Date`.
- **Fixing a closed issue:** don't reopen it or push to `main`. Make a small follow-up branch and PR that refers back to it ("Follow-up to #2").
- `git commit -- <path>` commits only that file, even when other files are staged.
- Uncommitted changes come along when you `git switch` branches.

---

## 2026-10-25: Project setup and data model

**Commits:** `64e8b89` … `3d24335` (PR #14)

### What changed
- Created the Xcode project and `.gitignore`, and stopped tracking `xcuserdata` (Issue 1).
- Added `CLAUDE.md`, the 13-issue plan in `github-issues.md`, and a README with the minimum iOS version.
- Added the `TodoItem` model and sample data (Issue 2).
