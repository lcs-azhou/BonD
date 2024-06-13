//
//  TaskItem.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-12.
//

import Foundation

// TaskItem 结构体，用于存储待办事项信息
struct TaskItem: Identifiable, Codable {
    let id: Int // 待办事项的唯一标识
    let taskName: String // 任务名称
    var completion: Bool // 任务是否完成

    enum CodingKeys: String, CodingKey {
        case id
        case taskName = "task_name"
        case completion
    }
}
