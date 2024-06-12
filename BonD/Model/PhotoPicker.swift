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

// 定义传输表示协议
protocol Transferable {
    static var transferRepresentation: TransferRepresentation { get }
}

// 传输表示结构体，包含加载方法
struct TransferRepresentation {
    let load: (PhotosPickerItem) async throws -> TodoItemImage
}

// TodoItemImage 结构体，表示待办事项的图片
struct TodoItemImage: Identifiable, Hashable {
    let id = UUID()
    let image: UIImage
}

// 扩展 TodoItemImage 以符合 Transferable 协议
extension TodoItemImage: Transferable {
    static var transferRepresentation: TransferRepresentation {
        TransferRepresentation { item in
            // 加载并验证图像数据
            guard let data = try await item.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else {
                throw NSError(domain: "Invalid Image Data", code: -1, userInfo: nil)
            }
            return TodoItemImage(image: image)
        }
    }
}
