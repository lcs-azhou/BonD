//
//  Message.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromCurrentUser: Bool
}
