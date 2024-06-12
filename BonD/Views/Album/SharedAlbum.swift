//
//  SharedAlbum.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI
import PhotosUI

// 共享相册视图，允许用户选择照片并显示已选择的照片列表
struct SharedAlbum: View {
    @StateObject private var viewModel = SharedAlbumViewModel() // 共享相册视图模型
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(height: 50)
                        .cornerRadius(16)
                        .padding()
                        .foregroundColor(.green) // 绿色矩形背景
                    
                    // 照片选择器按钮
                    PhotosPicker("Select Photo", selection: $viewModel.selectionResult, matching: .images)
                        .foregroundColor(.white)
                }
                
                // 显示已选择照片的列表
                List {
                    ForEach(viewModel.albumImages, id: \.id) { item in
                        Image(uiImage: item.image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .listStyle(.automatic)
            }
            .background {
                Color.green.opacity(0.5) // 设置背景颜色为绿色
                    .ignoresSafeArea()
            }
            .navigationTitle("Shared Album") // 设置导航栏标题
        }
    }
}

// 预览代码
#Preview {
    SharedAlbum()
}
