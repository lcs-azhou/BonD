//
//  TimerViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Combine
import Supabase

// TimerViewModel 负责管理计时器的逻辑
@MainActor
class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int // 剩余时间（以秒为单位）
    @Published var timerRunning: Bool = false // 计时器是否正在运行
    
    private var timer: AnyCancellable? // 计时器的订阅者
    private var taskId: Int // 任务 ID
    private var supabaseClient: SupabaseClient // Supabase 客户端
    
    // 初始化方法
    init(supabaseClient: SupabaseClient, taskId: Int, timeRemaining: Int = 1500) {
        self.supabaseClient = supabaseClient
        self.taskId = taskId
        self.timeRemaining = timeRemaining
        loadTimerState() // 加载计时器状态
    }
    
    // 开始计时器
    func startTimer() {
        timerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 && self.timerRunning {
                    self.timeRemaining -= 1
                } else {
                    self.timerRunning = false
                    self.timer?.cancel()
                }
                self.saveTimerState() // 保存计时器状态
            }
    }
    
    // 暂停计时器
    func pauseTimer() {
        timerRunning = false
        timer?.cancel()
        saveTimerState() // 保存计时器状态
    }
    
    // 重置计时器
    func resetTimer() {
        timerRunning = false
        timer?.cancel()
        timeRemaining = 1500
        saveTimerState() // 保存计时器状态
    }
    
    // 格式化时间
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // 保存计时器状态
    private func saveTimerState() {
        Task {
            do {
                let timerState = TimerState(
                    id: nil, // 不设置 id，数据库会自动生成
                    task_id: self.taskId,
                    time_remaining: self.timeRemaining,
                    timer_running: self.timerRunning,
                    updated_at: Date()
                )
                
                let _ = try await self.supabaseClient
                    .from("timers")
                    .upsert(timerState, returning: .minimal)
                    .execute()
            } catch {
                print("Error saving timer state to Supabase: \(error)")
            }
        }
    }
    
    // 加载计时器状态
    private func loadTimerState() {
        Task {
            do {
                let response: [TimerState] = try await self.supabaseClient
                    .from("timers")
                    .select()
                    .eq("task_id", value: self.taskId)
                    .execute()
                    .value
                
                if let timerState = response.first {
                    self.timeRemaining = timerState.time_remaining
                    self.timerRunning = timerState.timer_running
                }
            } catch {
                print("Error loading timer state from Supabase: \(error)")
            }
        }
    }
}
