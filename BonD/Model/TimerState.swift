//
//  TimerState.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-12.
//

import Foundation
import Supabase

// 定义 TimerState 结构体，表示计时器状态
struct TimerState: Codable, Identifiable {
    var id: Int? // 计时器状态唯一标识符，可选属性
    var task_id: Int // 任务唯一标识符
    var time_remaining: Int // 剩余时间，以秒为单位
    var timer_running: Bool // 计时器是否正在运行
    var updated_at: Date // 最后更新时间

    // 定义编码键，匹配 JSON 键
    enum CodingKeys: String, CodingKey {
        case id
        case task_id
        case time_remaining
        case timer_running
        case updated_at
    }
}
