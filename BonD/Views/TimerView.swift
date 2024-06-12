//
//  TimerView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Supabase

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    let todo: TaskItem

    @State private var selectedMinutes = 25
    
    var body: some View {
        VStack {
            Text(todo.taskName)
                .font(.largeTitle)
                .padding()
            
            Text(viewModel.formatTime(viewModel.timeRemaining))
                .font(.system(size: 48, weight: .bold))
                .padding()
            
            HStack {
                Picker("", selection: $selectedMinutes) {
                    ForEach(1..<61) { minute in
                        Text("\(minute) min")
                            .tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100)
                
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

#Preview {
    TimerView(viewModel: TimerViewModel( supabaseClient: supabaseClient, taskId: 1), todo: TaskItem(id: 1, taskName: "Homework", completion: false))
}
