//
//  ChatRoom.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-11.
//

import Foundation

// 定义 ChatRoom 结构体，表示聊天房间
struct ChatRoom: Codable {
    let id: Int? // 聊天房间唯一标识符，可选属性
    let code: String // 聊天房间的代码
    let created_at: String? // 创建时间，可选属性
}
