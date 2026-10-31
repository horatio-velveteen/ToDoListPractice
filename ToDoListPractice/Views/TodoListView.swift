//
//  TodoListView.swift
//  ToDoListPractice
//
//  Created by Ronald Brown on 10/26/26.
//
import SwiftUI
struct TodoListView: View {
    let viewModel: TodoListViewModel
    @State private var searchText = ""
    @State private var showActive = true
    @State private var showCompleted = true
    @State private var isAddingTask = false

    // Search only changes what is visible, never the stored data
    private var visibleTasks: [TodoItem] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return viewModel.todoList }
        return viewModel.todoList.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    private var activeTasks: [TodoItem] { visibleTasks.filter { !$0.isCompleted } }
    private var completedTasks: [TodoItem] { visibleTasks.filter { $0.isCompleted } }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                TaskViewHeader(searchText: $searchText)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                Divider()

                TaskGroupHeader(title: "Your Tasks", count: activeTasks.count, isExpanded: $showActive)
                if showActive {
                    taskListView(tasks: activeTasks, onToggle: { id in viewModel.toggleCompletion(id: id) })
                }

                if !completedTasks.isEmpty {
                    Divider()
                        .padding(.top, 8)
                    TaskGroupHeader(title: "Completed", count: completedTasks.count, isExpanded: $showCompleted)
                    if showCompleted {
                        taskListView(tasks: completedTasks, onToggle: { id in viewModel.toggleCompletion(id: id) })
                    }
                }
            }
            // Leaves room so the add button never covers the last row
            .padding(.bottom, 88)
        }
        .overlay(alignment: .bottomTrailing) {
            addTaskButton
        }
        .sheet(isPresented: $isAddingTask) {
            AddTaskSheet(onSave: { item in viewModel.add(item) })
        }
    }

    private var addTaskButton: some View {
        Button {
            isAddingTask = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Color.purple, in: .circle)
                .shadow(color: .black.opacity(0.2), radius: 6, y: 3)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Add task")
        .padding(20)
    }
}

struct TaskGroupHeader: View {
    let title: String
    let count: Int
    @Binding var isExpanded: Bool

    var body: some View {
        Button {
            withAnimation { isExpanded.toggle() }
        } label: {
            HStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                Text("(\(count))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isExpanded ? 0 : -90))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .accessibilityHint(isExpanded ? "Collapses the \(title) list" : "Expands the \(title) list")
    }
}

struct ItemView: View {
    let item: TodoItem
    var onToggle: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                    .font(.title3)
                    .foregroundStyle(item.isCompleted ? Color.secondary : Color.purple)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(item.isCompleted ? "Mark incomplete" : "Mark complete")

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .strikethrough(item.isCompleted)
                    .foregroundStyle(item.isCompleted ? .secondary : .primary)

                // Completed rows only show the title, like the reference design
                if !item.isCompleted {
                    if !item.notes.isEmpty {
                        Text(item.notes)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    if let due = item.dueDate {
                        Text("Due \(due, format: .dateTime.month(.abbreviated).day()) at \(due, format: .dateTime.hour().minute())")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct taskListView: View {
    let tasks: [TodoItem]
    var onToggle: (TodoItem.ID) -> Void

    var body: some View {
        ForEach(tasks, id: \.id) { todo in
            ItemView(item: todo, onToggle: { onToggle(todo.id) })
        }
    }
}

#Preview {
    TodoListView(viewModel: TodoListViewModel())
}
