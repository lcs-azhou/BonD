//
//  PhotoPicker.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-29.
//

import SwiftUI
import PhotosUI
import Foundation
import UniformTypeIdentifiers
import UIKit

protocol Transferable {
    static var transferRepresentation: TransferRepresentation { get }
}

struct TransferRepresentation {
    let load: (PhotosPickerItem) async throws -> TodoItemImage
}

struct TodoItemImage: Identifiable, Hashable {
    let id = UUID()
    let image: UIImage
}

extension TodoItemImage: Transferable {
    static var transferRepresentation: TransferRepresentation {
        TransferRepresentation { item in
            guard let data = try await item.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else {
                throw NSError(domain: "Invalid Image Data", code: -1, userInfo: nil)
            }
            return TodoItemImage(image: image)
        }
    }
}

