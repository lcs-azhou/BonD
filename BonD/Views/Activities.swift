//
//  Activities.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI
import PhotosUI

struct ActivitiesView: View {
    @StateObject private var viewModel = ActivitiesViewModel()
    @State private var isPresentingAddActivityView = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.newsItems.isEmpty {
                    VStack {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.green.opacity(0.5))
                        Text("There are no items in the list, please add your own event!")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                            .frame(width: 300)
                    }
                } else {
                    List(viewModel.newsItems) { item in
                        NavigationLink(destination: NewsDetailView(newsItem: item)) {
                            NewsListItemView(newsItem: item)
                                .padding(.vertical, 8)
                        }
                    }
                }
            }
            .navigationTitle("Activities")
            .navigationBarItems(trailing: Button(action: {
                isPresentingAddActivityView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isPresentingAddActivityView) {
                AddActivityView(viewModel: viewModel)
            }
        }
    }
}

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @ObservedObject var viewModel: ActivitiesViewModel
    
    @State private var photoPickerItem: PhotosPickerItem? = nil
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                    Text("Select Image")
                }
                .onChange(of: photoPickerItem) { newItem in
                    Task {
                        if let newItem, let data = try? await newItem.loadTransferable(type: Data.self) {
                            viewModel.selectedImageData = data
                        }
                    }
                }
                
                if let imageData = viewModel.selectedImageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 165)
                        .cornerRadius(8.0)
                } else {
                    Color.gray
                        .frame(height: 165)
                        .cornerRadius(8.0)
                }
            }
            .navigationTitle("Add Activity")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                viewModel.addActivity(title: title)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct NewsListItemView: View {
    let newsItem: NewsItem
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageData = newsItem.imageData, let uiImage = UIImage(data: Data(base64Encoded: imageData)!) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 165)
                    .cornerRadius(8.0)
            } else {
                Color.green.opacity(0.65)
                    .frame(height: 165)
                    .cornerRadius(8.0)
            }
            
            Text(newsItem.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
        }
    }
}

struct NewsDetailView: View {
    let newsItem: NewsItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageData = newsItem.imageData, let uiImage = UIImage(data: Data(base64Encoded: imageData)!) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                }
                Text(newsItem.title)
                    .font(.title)
            }
            .padding()
        }
        .navigationTitle(newsItem.title)
    }
}

#Preview {
    ActivitiesView()
}
