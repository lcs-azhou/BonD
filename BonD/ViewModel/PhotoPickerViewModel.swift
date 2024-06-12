//
//  PhotoPickerViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-29.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class SharedAlbumViewModel: ObservableObject {
    @Published var selectionResult: PhotosPickerItem? {
        didSet {
            if let selectionResult = selectionResult {
                loadTransferable(from: selectionResult)
            }
        }
    }
    @Published var albumImages: [TodoItemImage] = []
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) {
        Task {
            do {
                if let data = try await imageSelection.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    let newItemImage = TodoItemImage(image: uiImage)
                    self.albumImages.append(newItemImage)
                }
            } catch {
                debugPrint("Error loading image: \(error.localizedDescription)")
            }
        }
    }
}
