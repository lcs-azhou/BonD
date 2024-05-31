//
//  SharedAlbum.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI
import PhotosUI

struct SharedAlbum: View {
    @StateObject private var viewModel = SharedAlbumViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                PhotosPicker("Select Photo", selection: $viewModel.selectionResult, matching: .images)
                
                List {
                    ForEach(viewModel.albumImages, id: \.id) { item in
                        Image(uiImage: item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    }
                }
                .listStyle(.automatic)
            }
            .navigationTitle("Shared Album")
        }
    }
}

#Preview {
    SharedAlbum()
}
