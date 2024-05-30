//
//  PhotoPickerView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-29.
//

import SwiftUI

struct PhotoPickerView: View {
    @ObservedObject var viewModel: PhotoPickerViewModel

    var body: some View {
        PhotoPicker(selectedImages: $viewModel.selectedImages)
    }
}
