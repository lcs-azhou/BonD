//
//  TodoList.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-07.
//

import SwiftUI
import Supabase

struct TaskItem: Identifiable, Codable {
    let id: Int // 使用整数类型作为id
    let taskName: String
    var completion: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case taskName = "task_name"
        case completion
    }
}

struct TodoList: View {
    @State private var todos: [TaskItem] = []
    @State private var newTodoTitle = ""
    @State private var showAlert = false
    @State private var selectedTodo: TaskItem? = nil
    @State private var showTimerView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos) { todo in
                    HStack {
                        Text(todo.taskName)
                        Spacer()
                        if todo.completion {
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
                            print("\(todo.taskName) has been shared")
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
                            title: Text("Options for \(selectedTodo?.taskName ?? "")"),
                            message: Text("Choose an action to perform"),
                            primaryButton: .default(Text("Share"), action: {
                                if let selectedTodo = selectedTodo {
                                    print("\(selectedTodo.taskName) has been shared")
                                }
                            }),
                            secondaryButton: .default(Text("Start Timer"), action: {
                                showTimerView = true
                            })
                        )
                    }.sheet(isPresented: $showTimerView) {
                        if let selectedTodo = selectedTodo {
                            TimerView(viewModel: TimerViewModel(supabaseClient: supabaseClient, taskId: selectedTodo.id), todo: selectedTodo)
                        }
                    }
                }
                .onDelete(perform: deleteTodo)
            }
            .listStyle(.plain)
            .background {
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
        .onAppear(perform: loadTodos)
    }
    
    private func loadTodos() {
        Task {
            do {
                let response: [TaskItem] = try await supabaseClient
                    .from("task")
                    .select()
                    .execute()
                    .value
                
                self.todos = response
                
            } catch {
                print("Error loading todos: \(error)")
            }
        }
    }
    
    private func toggleCompletion(for todo: TaskItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].completion.toggle()
            updateTodoStatus(todo: todos[index])
        }
    }
    
    private func updateTodoStatus(todo: TaskItem) {
        Task {
            do {
                try await supabaseClient
                    .from("task")
                    .update(["completion": todo.completion])
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
                        .from("task")
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
        let newTodo = TaskItem(id: Int(Date().timeIntervalSince1970), taskName: newTodoTitle, completion: false)
        todos.append(newTodo)
        newTodoTitle = ""
        saveNewTodoToSupabase(newTodo)
    }
    
    private func saveNewTodoToSupabase(_ todo: TaskItem) {
        Task {
            do {
                let _ = try await supabaseClient
                    .from("task")
                    .insert([todo])
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
