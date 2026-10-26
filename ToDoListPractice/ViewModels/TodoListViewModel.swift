//
//  TodoListViewModel.swift
//  ToDoListPractice
//
//  Created by Ronald Brown on 10/25/26.
//
import Foundation
@Observable
class TodoListViewModel {
    
    var todoList: [TodoItem]
    
    init(todoList: [TodoItem]) {
        self.todoList = todoList
    }
}
