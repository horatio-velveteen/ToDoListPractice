import SwiftUI
import Playgrounds

struct ContentView: View {
    let viewModel: TodoListViewModel
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

#Preview {
    let viewModel = TodoListViewModel()

    ContentView(viewModel: viewModel)
}

#Playground {
    _ = 1 + 2
}
