//
//  TimerViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int
    @Published var timerRunning: Bool = false
    private var timer: AnyCancellable?
    
    init(timeRemaining: Int = 1500) {
        self.timeRemaining = timeRemaining
    }
    
    func startTimer() {
        timerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.timeRemaining > 0 && self.timerRunning {
                    self.timeRemaining -= 1
                } else {
                    self.timerRunning = false
                    self.timer?.cancel()
                }
            }
    }
    
    func pauseTimer() {
        timerRunning = false
        timer?.cancel()
    }
    
    func resetTimer() {
        timerRunning = false
        timer?.cancel()
        timeRemaining = 1500
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
