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
    
    var todoList: [TodoItem]
    
    init(todoList: [TodoItem] = TodoItem.createList()) {
        self.todoList = todoList
    }
}
