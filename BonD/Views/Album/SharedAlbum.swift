//
//  SharedAlbum.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI

struct SharedAlbum: View {
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(viewModel.selectedImages.chunked(into: 2)), id: \.self) { imageRow in
                    HStack(spacing: 16) {
                        ForEach(imageRow, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .frame(height: 100)
                        }
                    }
                }
            }

            
            Button(action: {
                viewModel.isPickerPresented.toggle()
            }) {
                Text("Add Photos")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $viewModel.isPickerPresented) {
                PhotoPickerView(viewModel: viewModel)
                    .presentationDetents([.medium, .fraction(0.6)])
            }
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map { startIndex in
            let endIndex = index(startIndex, offsetBy: size, limitedBy: self.count) ?? self.count
            return Array(self[startIndex..<endIndex])
        }
    }
}


#Preview {
    SharedAlbum()
}
