import SwiftUI

@main struct MyApp: App {
    @State private var viewModel = TodoListViewModel(todoList: TodoItem.createList())
    var body: some Scene {
        WindowGroup {
            TodoListView(viewModel: viewModel)
        }
    }
}
