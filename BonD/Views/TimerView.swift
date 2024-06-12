//
//  TimerView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Combine
import Supabase

// 计时器视图，显示待办事项的计时功能
struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel // 观察的视图模型对象
    let todo: TaskItem // 待办事项

    @State private var selectedMinutes = 25 // 选择的分钟数

    var body: some View {
        VStack {
            // 显示待办事项名称
            Text(todo.taskName)
                .font(.largeTitle)
                .padding()

            // 显示剩余时间
            Text(viewModel.formatTime(viewModel.timeRemaining))
                .font(.system(size: 48, weight: .bold))
                .padding()
            
            HStack {
                // 分钟选择器
                Picker("", selection: $selectedMinutes) {
                    ForEach(1..<61) { minute in
                        Text("\(minute) min")
                            .tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100)
                
                // 开始按钮
                Button(action: {
                    viewModel.timeRemaining = selectedMinutes * 60
                    viewModel.startTimer()
                }) {
                    Text("Start")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                
                // 暂停按钮
                Button(action: {
                    viewModel.pauseTimer()
                }) {
                    Text("Pause")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
        }
    }
}

// 预览代码
#Preview {
    TimerView(viewModel: TimerViewModel(supabaseClient: supabaseClient, taskId: 1), todo: TaskItem(id: 1, taskName: "Sample Task", completion: false))
}
