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
    var isFromCurrentUser: Bool
    
    // 定义编码键，匹配 JSON 键
    enum CodingKeys: String, CodingKey {
        case id
        case patron_id
        case message_text
        case chat_room_id
        // 不需要包含 isFromCurrentUser，因为这是一个计算属性，不会被编码/解码
    }

    // 初始化方法
    init(id: Int, patron_id: Int, message_text: String, chat_room_id: Int?, isFromCurrentUser: Bool) {
        self.id = id
        self.patron_id = patron_id
        self.message_text = message_text
        self.chat_room_id = chat_room_id
        self.isFromCurrentUser = isFromCurrentUser
    }
}
