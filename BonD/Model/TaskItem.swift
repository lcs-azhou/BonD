//
//  TaskItem.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-12.
//

import Foundation

struct TaskItem: Identifiable, Codable {
    let id: Int
    let taskName: String
    var completion: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case taskName = "task_name"
        case completion
    }
}
