//
//  Message.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import Foundation

struct Message: Codable, Identifiable {
    var id: Int
    var patron_id: Int
    var message_text: String
    var chat_room_id: Int?
    var isFromCurrentUser: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case patron_id
        case message_text
        case chat_room_id
    }
    
    init(id: Int, patron_id: Int, message_text: String, chat_room_id: Int?, isFromCurrentUser: Bool) {
        self.id = id
        self.patron_id = patron_id
        self.message_text = message_text
        self.chat_room_id = chat_room_id
        self.isFromCurrentUser = isFromCurrentUser
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        patron_id = try container.decode(Int.self, forKey: .patron_id)
        message_text = try container.decode(String.self, forKey: .message_text)
        chat_room_id = try container.decodeIfPresent(Int.self, forKey: .chat_room_id)
        isFromCurrentUser = false // 默认值，或根据您的逻辑设置
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(patron_id, forKey: .patron_id)
        try container.encode(message_text, forKey: .message_text)
        try container.encode(chat_room_id, forKey: .chat_room_id)
    }
}
