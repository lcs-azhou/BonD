//
//  TodoList.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI
import Supabase

struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

struct TodoList: View {
    @State private var todos: [TodoItem] = []
    @State private var newTodoTitle = ""
    @State private var showAlert = false
    @State private var selectedTodo: TodoItem? = nil
    @State private var showTimerView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos) { todo in
                    HStack {
                        Text(todo.title)
                        Spacer()
                        if todo.isCompleted {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggleCompletion(for: todo)
                    }
                    .contextMenu(menuItems: {
                        Button {
                            // viewModel.share(todo)
                            print("\(todo.title) has been shared")
                        } label: {
                            Label {
                                Text("Share")
                            } icon: {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                        Button {
                            selectedTodo = todo
                            showAlert = true
                        } label: {
                            Label {
                                Text("Start Timer")
                            } icon: {
                                Image(systemName: "timer")
                            }
                        }
                    }).alert(isPresented: $showAlert){
                        Alert(
                            title: Text("Options for \(selectedTodo?.title ?? "")"),
                            message: Text("Choose an action to perform"),
                            primaryButton: .default(Text("Share"), action: {
                                if let selectedTodo = selectedTodo {
                                    // share selectedTodo
                                    print("\(selectedTodo.title) has been shared")
                                }
                            }),
                            secondaryButton: .default(Text("Start Timer"), action: {
                                showTimerView = true
                            })
                        )
                    }.sheet(isPresented: $showTimerView) {
                        if let selectedTodo = selectedTodo {
                            TimerView(viewModel: TimerViewModel(), todo: selectedTodo)
                        }
                    }
                }
                .onDelete(perform: deleteTodo)
            }
            .listStyle(.plain)
            .background{
                Color(.green.opacity(0.3))
            }
            .navigationTitle("TodoList")
            .navigationBarItems(
                trailing: EditButton()
                    .foregroundColor(.green)
            )
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        TextField("add", text: $newTodoTitle, onCommit: addTodo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: addTodo) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    
    private func loadTodos() {
        Task {
            do {
                let response = try await supabaseClient
                    .from("TodoList")
                    .select()
                    .execute()
                
                if let todos = response.value as? [TodoItem] {
                    self.todos = todos
                } else {
                    print("Failed to decode todos")
                }
            } catch {
                print("Error loading todos: \(error)")
            }
        }
    }
    
    private func toggleCompletion(for todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
            updateTodoStatus(todo: todos[index])
        }
    }

    
    private func updateTodoStatus(todo: TodoItem) {
        Task {
            do {
                try await supabaseClient
                    .from("TodoList")
                    .update(["isCompleted": todo.isCompleted])
                    .eq("id", value: todo.id)
                    .execute()
            } catch {
                print("Error updating todo: \(error)")
            }
        }
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        offsets.map { todos[$0] }.forEach { todo in
            Task {
                do {
                    try await supabaseClient
                        .from("TodoList")
                        .delete()
                        .eq("id", value: todo.id)
                        .execute()
                } catch {
                    print("Error deleting todo: \(error)")
                }
            }
        }
        todos.remove(atOffsets: offsets)
    }
    
    private func addTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = TodoItem(title: newTodoTitle)
        todos.append(newTodo)
        newTodoTitle = ""
        saveNewTodoToSupabase(newTodo)
    }
    
    private func saveNewTodoToSupabase(_ todo: TodoItem) {
        Task {
            do {
                try await supabaseClient
                    .from("TodoList")
                    .insert(todo)
                    .execute()
            } catch {
                print("Error saving new todo: \(error)")
            }
        }
    }
}


#Preview {
    TodoList()
}
