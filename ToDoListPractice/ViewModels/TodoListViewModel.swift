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
    
}
