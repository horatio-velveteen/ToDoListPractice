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
    @State private var isExpanded = true

    // Search only changes what is visible, never the stored data
    private var visibleTasks: [TodoItem] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return viewModel.todoList }
        return viewModel.todoList.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                TaskViewHeader(searchText: $searchText, isExpanded: $isExpanded,
                               taskCount: visibleTasks.count)
                if isExpanded {
                    taskListView(tasks: visibleTasks)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
}

struct ItemView: View {
    let item: TodoItem
    var onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Circle()
                    .stroke(Color(.systemGray), lineWidth: 1.5)
                    .frame(width: 22, height: 22)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .foregroundStyle(.primary)
                if let due = item.dueDate {
                    Label("Due \(due.formatted())", systemImage: "flage.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

struct taskListView: View {
    let tasks: [TodoItem]

    var body: some View {
        ForEach(tasks, id: \.id) { todo in
            ItemView(item: todo, onToggle: {})
        }
    }
}
