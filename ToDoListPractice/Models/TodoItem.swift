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
    let isCompleted: Bool
    let dueDate: Date?
    let completedAt: Date?
    
    func dateToString(date: Date?) -> String {
        guard let date = date else { fatalError("Cannot Convert to string")}
        let dateFormat = "MM-dd-yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    static func stringToDate(from: String?) -> Date? {
        let stringDate = "10-25=2026"
        let dateFormatter = DateFormatter()
        let dateFormat = "MM-dd-yyyy"
        dateFormatter.dateFormat = dateFormat
        
        let returnedDate = dateFormatter.date(from: stringDate)
        guard let returnedDate = returnedDate else {
            fatalError("no returned date")
        }
        return returnedDate
    }
    
    static func createList() -> [TodoItem] {
        let exampleList: [TodoItem] = [
            TodoItem(title: "title1", notes: "notes1", isCompleted: true, dueDate: Date(), completedAt: stringToDate(from: "10-25=2026")),
                                       
            TodoItem(title: "title2", notes: "notes2", isCompleted: false, dueDate: nil, completedAt: stringToDate(from: "10-25=2026")),
            TodoItem(title: "title3", notes: "notes3", isCompleted: false, dueDate: stringToDate(from: "10-25=2026"), completedAt: stringToDate(from: "10-25=2026")),
            TodoItem(title: "title4", notes: "notes4", isCompleted: false, dueDate: nil, completedAt: stringToDate(from: "10-25=2026"))]
        return exampleList
    }
}
