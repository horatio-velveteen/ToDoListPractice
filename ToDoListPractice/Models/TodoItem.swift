//
//  TodoItem.swift
//  ToDoListPractice
//
//  Created by Ronald Brown on 10/25/26.
//
import Foundation
struct TodoItem: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var notes: String
    var dueDate: Date?
    var createdAt = Date()
    var completedAt: Date?
    // Derived from completedAt so the two can never contradict each other
    var isCompleted: Bool { completedAt != nil }
    
    // Created once and shared, since DateFormatter is expensive to create
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()

    static func dateToString(date: Date?) -> String {
        guard let date = date else { return "" }
        return Self.dateFormatter.string(from: date)
    }

    static func stringToDate(date: String?) -> Date? {
        guard let date else { return nil }
        return dateFormatter.date(from: date)
    }

    static func createList() -> [TodoItem] {
        let exampleList: [TodoItem] = [
            TodoItem(title: "title1", notes: "notes1", dueDate: stringToDate(date: "10/25/2026"), createdAt: stringToDate(date: "10/24/2026") ?? Date(), completedAt: stringToDate(date: "10/25/2026")),
            TodoItem(title: "title2", notes: "notes2", dueDate: stringToDate(date: "10/27/2026"), createdAt: stringToDate(date: "10/24/2026") ?? Date(), completedAt: nil),
            TodoItem(title: "title3", notes: "notes3", dueDate: stringToDate(date: "10/25/2026"), createdAt: stringToDate(date: "10/24/2026") ?? Date(), completedAt: nil),
            TodoItem(title: "title4", notes: "notes4", dueDate: stringToDate(date: "10/26/2026"), createdAt: stringToDate(date: "10/24/2026") ?? Date(), completedAt: nil)]
        return exampleList
    }
}
