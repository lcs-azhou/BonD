//
//  NewsItem.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-11.
//

import Foundation

struct NewsItem: Identifiable, Codable {
    var id: String
    var title: String
    var imageData: String? // 存储Base64编码的字符串
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageData = "image_data"
    }
}
