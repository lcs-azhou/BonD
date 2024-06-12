//
//  TimerViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Combine
import Supabase

@MainActor // 确保在主线程上执行
class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int
    @Published var timerRunning: Bool = false
    
    private var timer: AnyCancellable?
    private var taskId: Int
    private var supabaseClient: SupabaseClient
    
    init(supabaseClient: SupabaseClient, taskId: Int, timeRemaining: Int = 1500) {
        self.supabaseClient = supabaseClient
        self.taskId = taskId
        self.timeRemaining = timeRemaining
        loadTimerState()
    }
    
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
                self.saveTimerState()
            }
    }
    
    func pauseTimer() {
        timerRunning = false
        timer?.cancel()
        saveTimerState()
    }
    
    func resetTimer() {
        timerRunning = false
        timer?.cancel()
        timeRemaining = 1500
        saveTimerState()
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func saveTimerState() {
        Task {
            do {
                let timerState = TimerState(
                    id: nil, // Assuming id is auto-incremented in the database
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
