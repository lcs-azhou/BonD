//
//  PhotoPickerViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-29.
//

import SwiftUI
import PhotosUI

class PhotoPickerViewModel: ObservableObject {
    @Published var selectedImages: [UIImage] = []
    @Published var isPickerPresented: Bool = false

    func addImages(_ images: [UIImage]) {
        selectedImages.append(contentsOf: images)
    }
}
