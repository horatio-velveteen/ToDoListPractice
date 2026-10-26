//
//  TodoItem.swift
//  ToDoListPractice
//
//  Created by Ronald Brown on 10/25/26.
//
import Foundation
struct TodoItem: Codable {
    var id = UUID()
    let title: String
    let notes: String
    var isCompleted: Bool
    let dueDate: Date?
    let completedAt: Date?
    
    func dateToString(date: Date?) -> String {
        guard let date = date else { fatalError("Cannot Convert to string")}
        let dateFormat = "MM/dd/yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    static func stringToDate(date: String?) -> Date? {
        guard let date else { return nil }
        let dateFormatter = DateFormatter()
        let dateFormat = "MM-dd-yyyy"
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: date)
    }
    
    static func createList() -> [TodoItem] {
        let exampleList: [TodoItem] = [
            TodoItem(title: "title1", notes: "notes1", isCompleted: true, dueDate: stringToDate(date: "10-25-2026"),
                completedAt: stringToDate(date: "10-25-2026")),
            TodoItem(title: "title2", notes: "notes2", isCompleted: false, dueDate: stringToDate(date: "10-27-2026"), completedAt: nil),
            TodoItem(title: "title3", notes: "notes3", isCompleted: false, dueDate: stringToDate(date: "10-25-2026"), completedAt: nil),
            TodoItem(title: "title4", notes: "notes4", isCompleted: false, dueDate: stringToDate(date: "10-26-2026"), completedAt: nil)]
        return exampleList
    }
}
