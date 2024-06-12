import SwiftUI

struct TodoListView: View {
    @ObservedObject var viewModel: TodoListViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todos) { todo in
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
                        viewModel.toggleCompletion(for: todo)
                    }
                    .contextMenu {
                        Button {
                            print("\(todo.taskName) has been shared")
                        } label: {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        Button {
                            viewModel.selectedTodo = todo
                            viewModel.showAlert = true
                        } label: {
                            Label("Start Timer", systemImage: "timer")
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteTodo)
            }
            .listStyle(.plain)
            .background {
                Color.green.opacity(0.3)
            }
            .navigationTitle("TodoList")
            .navigationBarItems(trailing: EditButton().foregroundColor(.green))
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        TextField("add", text: $viewModel.newTodoTitle, onCommit: viewModel.addTodo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: viewModel.addTodo) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $viewModel.showTimerView) {
                if let selectedTodo = viewModel.selectedTodo {
                    TimerView(viewModel: TimerViewModel(supabaseClient: supabaseClient, taskId: selectedTodo.id), todo: selectedTodo)
                }
            }
        }
        .onAppear {
            viewModel.loadTodos()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        let fakeTodos = [
            TaskItem(id: 1, taskName: "Homework", completion: false),
            TaskItem(id: 2, taskName: "Groceries", completion: true)
        ]
        let viewModel = TodoListViewModel()
        viewModel.todos = fakeTodos
        return TodoListView(viewModel: viewModel)
    }
}
