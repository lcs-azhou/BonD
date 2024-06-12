//
//  Message.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: Int
    let text: String
    let patron_id: Int
    let isFromCurrentUser: Bool
    let profileImageURL: String?
    
    init(id: Int = 0, text: String, patron_id: Int, isFromCurrentUser: Bool, profileImageURL: String? = nil) {
        self.id = id
        self.text = text
        self.patron_id = patron_id
        self.isFromCurrentUser = isFromCurrentUser
        self.profileImageURL = profileImageURL
    }
}
