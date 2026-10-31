//
//  TaskEditorViewModel.swift
//  ToDoListPractice
//
//  Created by Ronald Brown on 10/29/26.
//
import Foundation
import Observation

// Holds a draft, so the real list only changes when the user saves
@Observable
class TaskEditorViewModel {
    var title = ""
    var notes = ""
    var dueDate: Date?

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var canSave: Bool { !trimmedTitle.isEmpty }

    func makeItem() -> TodoItem {
        TodoItem(title: trimmedTitle, notes: notes, dueDate: dueDate)
    }
}
