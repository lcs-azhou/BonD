//
//  TodoListView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-07.
//

import SwiftUI
import Supabase

struct TodoListView: View {
    @ObservedObject var viewModel: TodoListViewModel // 观察的视图模型对象

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todos) { todo in // 遍历待办事项
                    TodoRowView(todo: todo, viewModel: viewModel) // 每个待办事项的行视图
                }
                .onDelete(perform: viewModel.deleteTodo) // 删除待办事项的操作
            }
            .listStyle(.plain) // 设置列表样式
            .background {
                Color.green.opacity(0.3) // 设置背景颜色
            }
            .navigationTitle("TodoList") // 设置导航栏标题
            .navigationBarItems(trailing: EditButton().foregroundColor(.green)) // 编辑按钮
            .toolbar {
                ToolbarItem(placement: .bottomBar) { // 底部工具栏项
                    HStack {
                        TextField("Add", text: $viewModel.newTodoTitle, onCommit: viewModel.addTodo) // 添加新待办事项的文本框
                            .textFieldStyle(RoundedBorderTextFieldStyle()) // 设置文本框样式
                        Button(action: viewModel.addTodo) { // 添加待办事项的按钮
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $viewModel.showTimerView) { // 显示计时器视图的弹出窗
                if let selectedTodo = viewModel.selectedTodo { // 如果有选中的待办事项
                    TimerView(viewModel: TimerViewModel(supabaseClient: supabaseClient, taskId: selectedTodo.id), todo: selectedTodo) // 显示计时器视图
                }
            }
        }
        .onAppear {
            viewModel.loadTodos() // 视图出现时加载待办事项
        }
    }
}

struct TodoRowView: View {
    let todo: TaskItem // 待办事项
    @ObservedObject var viewModel: TodoListViewModel // 观察的视图模型对象

    var body: some View {
        HStack {
            Text(todo.taskName) // 显示待办事项名称
            Spacer()
            if todo.completion {
                Image(systemName: "checkmark") // 如果待办事项已完成，显示对勾图标
                    .foregroundColor(.green)
            }
        }
        .contentShape(Rectangle()) // 设置可点击区域
        .onTapGesture {
            viewModel.toggleCompletion(for: todo) // 点击待办事项行时切换完成状态
        }
        .contextMenu {
            Button {
                print("\(todo.taskName) has been shared") // 分享按钮操作
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            Button {
                viewModel.selectedTodo = todo // 设置选中的待办事项
                viewModel.showTimerView = true // 显示计时器视图
            } label: {
                Label("Start Timer", systemImage: "timer")
            }
        }
    }
}

#Preview {
    TodoListView(viewModel: TodoListViewModel(supabaseClient: supabaseClient)) // 预览代码
}
