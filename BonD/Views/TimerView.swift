//
//  TimerView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Combine

// 显示计时器的视图
struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    let todo: TaskItem

    @State private var selectedMinutes = 25

    var body: some View {
        VStack {
            // 显示任务名称
            Text(todo.taskName)
                .font(.largeTitle)
                .padding()

            // 显示剩余时间
            Text(viewModel.formatTime(viewModel.timeRemaining))
                .font(.system(size: 48, weight: .bold))
                .padding()
            
            VStack {
                // 选择分钟数的选择器
                Picker("", selection: $selectedMinutes) {
                    ForEach(1..<61) { minute in
                        Text("\(minute) min")
                            .tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100)
                
                // 开始计时按钮
                Button(action: {
                    viewModel.timeRemaining = selectedMinutes * 60
                    viewModel.startTimer()
                }) {
                    Text("Start")
                        .font(.caption2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                
                // 暂停计时按钮
                Button(action: {
                    viewModel.pauseTimer()
                }) {
                    Text("Pause")
                        .font(.caption2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                
                // 召唤进行中的timer按钮
                Button(action: {
                    viewModel.loadRunningTimer()
                }) {
                    Text("Resume")
                        .font(.caption2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
        }
    }
}

// 预览
#Preview {
    TimerView(viewModel: TimerViewModel(supabaseClient: supabaseClient, taskId: 1), todo: TaskItem(id: 1, taskName: "Sample Task", completion: false))
}
