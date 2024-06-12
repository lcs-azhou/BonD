//
//  Patron.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-11.
//

import Foundation

// 定义 Patron 结构体，表示用户
struct Patron: Codable, Identifiable {
    var id: Int // 用户唯一标识符
    var name_first: String // 用户的名字
    var name_last: String // 用户的姓氏
    var email: String // 用户的邮箱
    var profile_image_url: String? // 用户的头像 URL，可选属性
}
