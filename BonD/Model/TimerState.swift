//
//  TimerState.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-12.
//

import Foundation

// TimerState 结构体，用于存储计时器状态
struct TimerState: Codable, Identifiable {
    var id: Int? // 计时器状态的唯一标识，可能为空
    var task_id: Int // 关联的任务 ID
    var time_remaining: Int // 剩余时间
    var timer_running: Bool // 计时器是否正在运行
    var updated_at: Date // 上次更新时间

    enum CodingKeys: String, CodingKey {
        case id
        case task_id
        case time_remaining
        case timer_running
        case updated_at
    }
}
