//
//  NewsItem.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-11.
//

import Foundation

// 定义 NewsItem 结构体，表示新闻项
struct NewsItem: Identifiable, Codable {
    var id: String // 唯一标识符
    var title: String // 新闻标题
    var imageData: String? // 存储Base64编码的字符串
    var actText: String? // 活动描述
    var author: String // 活动作者
    
    // 定义编码键，匹配 JSON 键
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageData = "image_data" // 自定义 JSON 键名
        case actText = "act_text" // 自定义 JSON 键名
        case author
    }
}
