//
//  TaskItem.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-12.
//

import Foundation

// 定义 TaskItem 结构体，表示待办事项项
struct TaskItem: Identifiable, Codable {
    let id: Int // 待办事项唯一标识符
    let taskName: String // 待办事项名称
    var completion: Bool // 待办事项是否完成

    // 定义编码键，匹配 JSON 键
    enum CodingKeys: String, CodingKey {
        case id
        case taskName = "task_name" // 自定义 JSON 键名
        case completion
    }
}
