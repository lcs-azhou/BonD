//
//  TimerState.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-12.

import Foundation
import Supabase

struct TimerState: Codable, Identifiable {
    var id: Int?
    var task_id: Int
    var time_remaining: Int
    var timer_running: Bool
    var updated_at: Date

    enum CodingKeys: String, CodingKey {
        case id
        case task_id
        case time_remaining
        case timer_running
        case updated_at
    }
}
