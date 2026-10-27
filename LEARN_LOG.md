# Learn Log

What changed each day and what I learned along the way. Newest first.

---

## 2026-10-27: Task list screen, header, and completing tasks

**Branch:** `issue-3-task-list` (commits `8070c22`, `bb12d7c`)
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

### What I learned
- **`@State` vs `@Binding`:** state belongs to the view that *owns* it. When a child (the header) needs to change something the parent's other children (the list) react to, keep the `@State` in the parent and pass a `$binding` down.
- **`@FocusState`** tells a view whether a text field is focused. That's how the search border turns blue.
- **Views report, view models change:** a child view takes a closure like `onToggle: (TodoItem.ID) -> Void` and calls it. It never changes the data itself. Then `@Observable` redraws the screen when the view model's data changes.
- **Find items by `id`, not by index:** once the list is filtered by search, row 2 on screen isn't `todoList[2]`. `firstIndex(where: { $0.id == id })` always finds the right task.
- **Computed properties for filtering** (`visibleTasks`, `activeTasks`, `completedTasks`) change what's shown without touching stored data.
- **Name views for what they are:** a view that also draws rows isn't a "header". Splitting it made each piece reusable (`TaskGroupHeader` is used twice).
- A misspelled SF Symbol name still compiles. It just shows nothing at runtime.
- Plan mode: map out the data flow and the files/lines to change *before* coding.

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
