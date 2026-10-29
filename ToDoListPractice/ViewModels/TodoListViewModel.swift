//
//  TodoListViewModel.swift
//  ToDoListPractice
//
//  Created by Ronald Brown on 10/25/26.
//
import Foundation
import Observation
@Observable
class TodoListViewModel {
    
    var todoList: [TodoItem] = []
    
    init(todoList: [TodoItem] = []) {
        self.initializeList(todoList: todoList)
    }
    
    func initializeList(todoList: [TodoItem]) {
        if todoList.isEmpty {
            self.todoList = TodoItem.createList()
        } else {
            self.todoList = todoList
        }
    }

    // Looks up by id, since filtered rows don't line up with todoList indexes
    func toggleCompletion(id: TodoItem.ID) {
        guard let index = todoList.firstIndex(where: { $0.id == id }) else { return }
        todoList[index].completedAt = todoList[index].isCompleted ? nil : Date()
    }

}
