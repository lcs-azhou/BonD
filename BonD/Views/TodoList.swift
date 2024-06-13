//
//  TodoListView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-07.
//

import SwiftUI
import Supabase

// 显示待办事项列表和计时器的视图
struct TodoListView: View {
    @ObservedObject var viewModel: TodoListViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todos) { todo in
                    TodoRowView(todo: todo, viewModel: viewModel) // 每个待办事项的行视图
                }
                .onDelete(perform: viewModel.deleteTodo) // 删除待办事项
            }
            .listStyle(.plain)
            .background {
                Color.green.opacity(0.3)
            }
            .navigationTitle("TodoList")
            .navigationBarItems(trailing: EditButton().foregroundColor(.green)) // 编辑按钮
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        TextField("add", text: $viewModel.newTodoTitle, onCommit: viewModel.addTodo) // 添加待办事项的输入框
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: viewModel.addTodo) { // 添加待办事项按钮
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $viewModel.showTimerView) {
                if let selectedTodo = viewModel.selectedTodo {
                    TimerView(viewModel: TimerViewModel(supabaseClient: viewModel.supabaseClient, taskId: selectedTodo.id), todo: selectedTodo) // 显示计时器视图
                }
            }
        }
        .onAppear {
            viewModel.loadTodos() // 加载待办事项
        }
    }
}

// 显示单个待办事项行的视图
struct TodoRowView: View {
    let todo: TaskItem
    @ObservedObject var viewModel: TodoListViewModel

    var body: some View {
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
            viewModel.toggleCompletion(for: todo) // 切换完成状态
        }
        .contextMenu {
            Button {
                viewModel.selectedTodo = todo
                viewModel.showTimerView = true
            } label: {
                Label("Start Timer", systemImage: "timer") // 启动计时器
            }
        }
    }
}

// 预览
#Preview {
    TodoListView(viewModel: TodoListViewModel(supabaseClient: supabaseClient))
}
