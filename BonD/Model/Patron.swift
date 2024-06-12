//
//  Patron.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-11.
//

import Foundation

struct Patron: Codable, Identifiable {
    var id: Int
    var name_first: String
    var name_last: String
    var email: String
    var profile_image_url: String?
}

