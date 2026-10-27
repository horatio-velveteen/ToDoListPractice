//
//  TaskViewHeader.swift
//  ToDoListPractice
//
//  Created by Ronald Brown on 10/27/26.
//
import SwiftUI

struct TaskViewHeader: View {
    // Owned by the parent so the list below the header can react to it
    @Binding var searchText: String

    @FocusState private var isSearchFocused: Bool

    private let burntOrange = Color(red: 0.80, green: 0.33, blue: 0.00)

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            navigationBar
            searchBar

            Text("My tasks")
                .font(.system(size: 15, weight: .semibold))
        }
    }

    private var navigationBar: some View {
        HStack(spacing: 20) {
            Circle()
                .fill(burntOrange)
                .frame(width: 32, height: 32)
                .overlay {
                    Text("A")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .accessibilityLabel("Account")

            Spacer()

            Button("Filter", systemImage: "line.3.horizontal.decrease") {}
            Button("Sort", systemImage: "arrow.up.arrow.down") {}
            Button("More", systemImage: "ellipsis") {}
        }
        .labelStyle(.iconOnly)
        .buttonStyle(.plain)
        .font(.system(size: 17))
    }

    private var searchBar: some View {
        HStack {
            TextField("Find tasks", text: $searchText)
                .textFieldStyle(.plain)
                .focused($isSearchFocused)
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.blue.opacity(0.06), in: .rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSearchFocused ? Color.blue : Color.secondary.opacity(0.3), lineWidth: 1)
        }
        .animation(.easeInOut(duration: 0.15), value: isSearchFocused)
    }
}

#Preview {
    TaskViewHeader(searchText: .constant(""))
        .padding()
}
