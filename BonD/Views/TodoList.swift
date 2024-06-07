//
//  TodoList.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TodoList: View {
    @State private var todos: [TodoItem] = [
        TodoItem(title: "购物"),
        TodoItem(title: "学习"),
        TodoItem(title: "锻炼")
    ]
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
    
    
    private func toggleCompletion(for todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
    
    private func addTodo() {
        guard !newTodoTitle.isEmpty else { return }
        todos.append(TodoItem(title: newTodoTitle))
        newTodoTitle = ""
    }
}

#Preview {
    TodoList()
}
