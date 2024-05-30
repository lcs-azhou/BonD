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
        NavigationStack {
            List {
                ForEach(0..<viewModel.selectedImages.count, id: \.self) { index in
                                    let image = viewModel.selectedImages[index]
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(10)
                                        .frame(height: 100)
                                }
                }
            }.navigationTitle("Shared Album")
            .navigationBarItems(
                trailing: viewModel.selectedImages.isEmpty ?
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
                    } as! AnyView :
                    AnyView(EditButton().foregroundColor(.green))
            )
        }
    }


#Preview {
    SharedAlbum()
}
