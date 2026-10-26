# ToDo List: GitHub Issues (copy-paste)

How to use: for each issue below, copy the **Title** block into GitHub's title field and the **Body** block into the description field. The `- [ ]` lines turn into clickable checkboxes on GitHub. Create them in order (1 to 13) so the issue numbers match the "Depends on" lines.

Optional labels to create first: `size:S`, `size:M`, `size:L`, `ui`, `no-ui`.

---

## Issue 1

Labels: `size:S`, `no-ui`

**Title**
```
Project setup
```

**Body**
```
## What and why
Create the Xcode project, git repo, and folder structure so every later ticket has a home. Doing this first means you commit from day one.

## Acceptance criteria
- [ ] App builds and launches in the simulator showing a placeholder screen
- [ ] Repo is on GitHub with a first commit and a .gitignore for Xcode
- [ ] Folders exist for Models, Views, ViewModels, Storage
- [ ] Minimum iOS version is chosen and written in the README

## Hints
- Xcode "App" template
- .gitignore for Swift/Xcode
- Deployment target

## Design reference
None, no UI

## Size
S

## Depends on
Nothing
```

---

## Issue 2

Labels: `size:S`, `no-ui`

**Title**
```
Add TodoItem model and sample data
```

**Body**
```
## What and why
Define the data type for a task and a small array of sample tasks. Everything else builds on this shape, so get it right now.

## Acceptance criteria
- [ ] TodoItem has: id (UUID), title (String), notes (String), isCompleted (Bool), dueDate (Date?), createdAt (Date), completedAt (Date?)
- [ ] A sample array of 4 or more items exists, including a completed one and one with a due date
- [ ] App still launches

## Hints
- Structs vs classes
- Identifiable
- Codable
- UUID

## Design reference
None, no UI

## Size
S

## Depends on
#1
```

---

## Issue 3

Labels: `size:M`, `ui`

**Title**
```
Task list screen with sample data
```

**Body**
```
## What and why
Show the sample tasks in a scrolling list with a checkbox, title, and a struck-through style for completed items. This is your first real UI.

## Acceptance criteria
- [ ] Launching shows all sample tasks in a list
- [ ] Completed tasks look visibly different from active ones
- [ ] A due date appears under the title when one exists
- [ ] Navigation title says "Tasks"

## Hints
- List and ForEach
- NavigationStack
- Label
- Text styling modifiers
- Extracting a row into its own subview

## Design reference
- Evernote task list (sections for active and completed): https://mobbin.com/screens/e5da9609-b2d9-4a47-a401-672f628345b5
- Attio My tasks: https://mobbin.com/screens/24d97071-f951-4c50-b21a-cabe794fe10e

## Size
M

## Depends on
#2
```

---

## Issue 4

Labels: `size:M`, `no-ui`

**Title**
```
Introduce TaskListViewModel
```

**Body**
```
## What and why
Move the task array out of the view and into a view model that owns it. The view should no longer hold or change data itself; it only displays state and reports taps.

## Acceptance criteria
- [ ] The list looks and behaves the same as before
- [ ] The view contains no task data of its own, only a reference to the view model
- [ ] Changing the data in the view model changes what the screen shows

## Hints
- ObservableObject with @Published vs the @Observable macro
- @StateObject / @State for ownership
- "Single source of truth"

## Design reference
None, no UI

## Size
M

## Depends on
#3
```

---

## Issue 5

Labels: `size:S`, `ui`

**Title**
```
Toggle task complete / incomplete
```

**Body**
```
## What and why
Tapping the checkbox flips a task between complete and incomplete. It is the app's most common action, so it should feel instant.

## Acceptance criteria
- [ ] Tapping a checkbox changes that row's look
- [ ] Tapping again reverses it
- [ ] Only the tapped row changes
- [ ] completedAt is set when completing and cleared when un-completing (check with a temporary debug print or the debugger)

## Hints
- Button inside a list row
- buttonStyle(.plain)
- Finding an item by id
- SF Symbols for checkbox icons

## Design reference
- Attio list with "Task completed" toast: https://mobbin.com/screens/24d97071-f951-4c50-b21a-cabe794fe10e
- Evernote task list: https://mobbin.com/screens/e5da9609-b2d9-4a47-a401-672f628345b5

## Size
S

## Depends on
#4
```

---

## Issue 6

Labels: `size:M`, `ui`

**Title**
```
Add task sheet
```

**Body**
```
## What and why
An Add button opens a sheet with a title field and Save/Cancel. This introduces the editor view model and the idea of editing a draft copy instead of the real data.

## Acceptance criteria
- [ ] Add button opens a sheet
- [ ] Save is disabled while the title is empty or only spaces
- [ ] Saving adds the task and closes the sheet
- [ ] Cancel closes the sheet and adds nothing
- [ ] The keyboard appears automatically in the title field

## Hints
- .sheet
- @FocusState
- .disabled
- Passing a closure (callback) from parent to child
- trimmingCharacters

## Design reference
- Attio Create Task sheet: https://mobbin.com/screens/7c081b9d-d7db-4314-8fbd-e639611227c8
- Joi new task: https://mobbin.com/screens/244a4760-9529-4141-8afb-be131f475f30

## Size
M

## Depends on
#4
```

---

## Issue 7

Labels: `size:S`, `ui`

**Title**
```
Empty state
```

**Body**
```
## What and why
When there are no tasks, show a friendly message and a way to add the first one instead of a blank screen.

## Acceptance criteria
- [ ] With zero tasks, the message and add action appear
- [ ] Adding a task makes the message disappear
- [ ] Clearing all tasks (use a temporary debug button) brings the message back

## Hints
- ContentUnavailableView (check its minimum iOS version)
- Conditional views
- Group

## Design reference
- Attio "No Tasks": https://mobbin.com/screens/be0471bf-0192-4057-b23f-ba463960aa30
- Airtasker empty My tasks: https://mobbin.com/screens/5da3677d-3758-406a-a4ed-5d6e03ca4581

## Size
S

## Depends on
#6
```

---

## Issue 8

Labels: `size:S`, `ui`

**Title**
```
Swipe to delete
```

**Body**
```
## What and why
Swiping a row left reveals Delete. The list view reports the swipe and the view model removes the task.

## Acceptance criteria
- [ ] Swiping a row shows a Delete action
- [ ] Tapping it removes only that task
- [ ] Deleting the last task shows the empty state

## Hints
- swipeActions
- onDelete
- role: .destructive
- Removing by id vs by index (and why index can be risky)

## Design reference
- X Drafts swipe delete: https://mobbin.com/screens/a449d9e5-38db-46ab-80bc-4552b207cfe0
- Swiggy list row delete: https://mobbin.com/screens/c404d36b-e87e-460e-a7fe-f2c3bcc92ec7

## Size
S

## Depends on
#7
```

---

## Issue 9

Labels: `size:L`, `ui`

**Title**
```
Task detail and edit screen
```

**Body**
```
## What and why
Tapping a row opens a screen to edit title and notes, with Save, Cancel, and Delete. It reuses the editor view model from the Add sheet in "edit" mode.

## Acceptance criteria
- [ ] Tapping a row opens the detail screen filled with that task's data
- [ ] Editing and saving updates the row in the list
- [ ] Cancel after editing asks before discarding changes
- [ ] Delete asks for confirmation, then returns to the list with the task gone

## Hints
- NavigationLink with a value, and navigationDestination
- confirmationDialog
- TextEditor
- The dismiss environment value

## Design reference
- Evernote task detail: https://mobbin.com/screens/96dca75a-f565-4e5e-9847-390cc1007dc4

## Size
L

## Depends on
#8
```

---

## Issue 10

Labels: `size:L`, `ui`

**Title**
```
Persistence with loading and error states
```

**Body**
```
## What and why
Save tasks to a JSON file and load them at launch so data survives restarts. This is also where the Loading and Error states become real.

## Acceptance criteria
- [ ] Add a task, kill the app, relaunch: the task is still there
- [ ] Toggling, editing, and deleting are also saved
- [ ] First launch (no file yet) shows the empty state, not an error
- [ ] Corrupting the file on purpose shows the error screen with a Retry button (test by editing the file by hand)
- [ ] Retry goes back to Loading, then to Loaded or Error

## Hints
- Codable
- JSONEncoder / JSONDecoder
- FileManager and the Documents directory
- async/await and Task
- Protocols for dependency injection (TaskStore)

## Design reference
Loose matches for the error layout:
- FocusFlight failure screen: https://mobbin.com/screens/1a121ed5-664d-4c31-81de-acfd575df302
- DoorDash Dasher retry screen: https://mobbin.com/screens/a8008758-8d21-4272-ab34-7dcf4fbf485d

## Size
L

## Depends on
#9
```

---

## Issue 11

Labels: `size:M`, `ui`

**Title**
```
Due dates and overdue styling
```

**Body**
```
## What and why
Let users optionally set a due date in the add and edit screens, and mark overdue tasks in the list.

## Acceptance criteria
- [ ] Add and edit screens have a due date control that can be set and cleared
- [ ] The list shows the date on rows that have one
- [ ] An incomplete task whose date has passed is shown in a warning style
- [ ] Completed tasks are never shown as overdue
- [ ] Dates survive relaunch

## Hints
- DatePicker
- Toggle bound to an optional value
- Calendar.isDateInToday
- Date.formatted

## Design reference
- Superlist due date picker: https://mobbin.com/screens/81b1dbef-6f67-4068-8aab-8347653a97c3
- Attio rows with date chips: https://mobbin.com/screens/24d97071-f951-4c50-b21a-cabe794fe10e

## Size
M

## Depends on
#10
```

---

## Issue 12

Labels: `size:M`, `ui`

**Title**
```
Filter and search
```

**Body**
```
## What and why
Add an All / Active / Completed filter and a search box. Both only change what is visible, never the stored data.

## Acceptance criteria
- [ ] Switching the filter shows only matching tasks
- [ ] Typing in search narrows the list by title, ignoring upper/lower case
- [ ] Filter and search work together
- [ ] A "no matches" message appears when nothing fits
- [ ] Clearing the search restores the list

## Hints
- .searchable
- Picker with a segmented style
- Computed properties
- localizedCaseInsensitiveContains

## Design reference
- Evernote search field and filter: https://mobbin.com/screens/e5da9609-b2d9-4a47-a401-672f628345b5
- Superlist search results: https://mobbin.com/screens/54506b4b-9282-4bc1-b79d-2c1a48adf5a9

## Size
M

## Depends on
#10
```

---

## Issue 13

Labels: `size:M`, `no-ui`

**Title**
```
Polish and testing
```

**Body**
```
## What and why
Tighten the rough edges and add unit tests for the logic that matters most. This is the "would I show this to someone" pass.

## Acceptance criteria
- [ ] Works in light and dark mode
- [ ] Text stays readable at the largest Dynamic Type size
- [ ] VoiceOver reads checkbox state and task title sensibly
- [ ] An app icon and launch screen are set
- [ ] Unit tests exist for: adding, toggling, deleting, filtering, and the overdue rule
- [ ] All tests pass
- [ ] README explains how to run the app

## Hints
- XCTest or Swift Testing
- Accessibility labels and traits
- Dynamic Type
- Asset catalog
- Testing a view model with a fake TaskStore

## Design reference
None, no new UI (any visual tweaks should follow the references in issues 3 to 12)

## Size
M

## Depends on
#11, #12
```
