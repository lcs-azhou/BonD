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
                ZStack {
                    Rectangle()
                        .frame(height:50)
                        .cornerRadius(16)
                        .padding()
                        .foregroundColor(.green)
                    PhotosPicker("Select Photo", selection: $viewModel.selectionResult, matching: .images)
                        .foregroundColor(.white)
                }
                
                List {
                    ForEach(viewModel.albumImages, id: \.id) { item in
                        Image(uiImage: item.image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .listStyle(.automatic)
            }.background{
                Color(.green.opacity(0.5))
                    .ignoresSafeArea()
            }
            .navigationTitle("Shared Album")
        }
    }
}

#Preview {
    SharedAlbum()
}
