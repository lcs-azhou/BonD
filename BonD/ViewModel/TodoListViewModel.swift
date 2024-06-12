//
//  TodoListViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-07.
//

import Foundation
import Supabase

@MainActor
class TodoListViewModel: ObservableObject {
    @Published var todos: [TaskItem] = []
    @Published var newTodoTitle = ""
    @Published var showAlert = false
    @Published var selectedTodo: TaskItem? = nil
    @Published var showTimerView = false

    private var supabaseClient: SupabaseClient

    init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
        loadTodos()
    }

    // 加载待办事项
    func loadTodos() {
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

    // 切换待办事项的完成状态
    func toggleCompletion(for todo: TaskItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].completion.toggle()
            updateTodoStatus(todo: todos[index])
        }
    }

    // 更新待办事项状态
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

    // 删除待办事项
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

    // 添加新待办事项
    func addTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = TaskItem(id: Int(Date().timeIntervalSince1970), taskName: newTodoTitle, completion: false)
        todos.append(newTodo)
        newTodoTitle = ""
        saveNewTodoToSupabase(newTodo)
    }

    // 将新待办事项保存到 Supabase
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
