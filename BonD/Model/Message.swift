//
//  Message.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import Foundation

// Message 结构体，表示聊天消息
struct Message: Codable, Identifiable {
    var id: Int
    var patron_id: Int
    var message_text: String
    var chat_room_id: Int?
    
    // 计算属性，用于判断消息是否来自当前用户
    var isFromCurrentUser: Bool {
        // 根据逻辑判断当前用户
        return patron_id == 1 // 示例逻辑，根据实际情况修改
    }
    
    // 定义编码键，匹配 JSON 键
    enum CodingKeys: String, CodingKey {
        case id
        case patron_id
        case message_text
        case chat_room_id
    }
}

