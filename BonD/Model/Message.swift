//
//  Message.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: Int? // 从Int改为Int?以匹配数据库中的ID
    let text: String
    let patron_id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case text = "message_text"
        case patron_id
    }
}
