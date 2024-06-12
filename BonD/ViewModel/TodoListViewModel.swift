//
//  TodoListViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-07.
//

import Foundation
import Supabase

class TodoListViewModel: ObservableObject {
    @Published var todos: [TaskItem] = []
    @Published var newTodoTitle = ""
    @Published var showAlert = false
    @Published var selectedTodo: TaskItem? = nil
    @Published var showTimerView = false

    init() {
        
            loadTodos()
        
    }

    func loadTodos() {
        Task {
            do {
                let response: [TaskItem] = try await supabaseClient
                    .from("task")
                    .select()
                    .execute()
                    .value

                DispatchQueue.main.async {
                    self.todos = response
                }
            } catch {
                print("Error loading todos: \(error)")
            }
        }
    }

    func toggleCompletion(for todo: TaskItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].completion.toggle()
            updateTodoStatus(todo: todos[index])
        }
    }

    func updateTodoStatus(todo: TaskItem) {
       
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

    func deleteTodo(at offsets: IndexSet) {
        
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

    func addTodo() {
        
        let newTodo = TaskItem(id: Int(Date().timeIntervalSince1970), taskName: newTodoTitle, completion: false)
        todos.append(newTodo)
        newTodoTitle = ""
        saveNewTodoToSupabase(newTodo)
    }

    func saveNewTodoToSupabase(_ todo: TaskItem) {
        
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
