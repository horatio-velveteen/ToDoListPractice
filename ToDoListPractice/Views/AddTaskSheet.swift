//
//  AddTaskSheet.swift
//  ToDoListPractice
//
//  Created by Ronald Brown on 10/29/26.
//
import SwiftUI

struct AddTaskSheet: View {
    var onSave: (TodoItem) -> Void

    @State private var viewModel = TaskEditorViewModel()
    @FocusState private var isFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $viewModel.title)
                    .focused($isFieldFocused)
                TextField("Notes", text: $viewModel.notes)
                    .focused($isFieldFocused)
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(viewModel.makeItem())
                        dismiss()
                    }
                    .disabled(!viewModel.canSave)
                }
            }
            .task { isFieldFocused = true }
        }
    }
}

#Preview {
    AddTaskSheet(onSave: { _ in })
}
