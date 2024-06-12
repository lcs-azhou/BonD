//
//  Activities.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI
import PhotosUI

// 主视图，显示活动列表并允许添加新活动
struct ActivitiesView: View {
    @StateObject private var viewModel = ActivitiesViewModel() // 活动视图模型
    @State private var isPresentingAddActivityView = false // 控制是否展示添加活动视图
    @State private var author: String // 活动的作者

    // 初始化方法，设置作者
    init(author: String) {
        _author = State(initialValue: author)
    }

    var body: some View {
        NavigationView {
            VStack {
                // 如果活动列表为空，显示提示信息
                if viewModel.newsItems.isEmpty {
                    VStack {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .foregroundColor(.green.opacity(0.5))
                        Text("There are no items in the list, please add your own event!")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                            .frame(width: 300)
                    }
                } else {
                    // 如果活动列表不为空，显示活动列表
                    List(viewModel.newsItems) { item in
                        NavigationLink(destination: NewsDetailView(newsItem: item)) {
                            NewsListItemView(newsItem: item)
                                .padding(.vertical, 8)
                        }
                    }
                }
            }
            .navigationTitle("Activities") // 设置导航栏标题
            .navigationBarItems(trailing: Button(action: {
                isPresentingAddActivityView = true // 显示添加活动视图
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isPresentingAddActivityView) {
                AddActivityView(viewModel: viewModel, author: author) // 弹出添加活动视图
            }
        }
    }
}

// 添加活动视图，允许用户输入活动标题和描述，并选择图片
struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode // 环境变量，用于关闭视图
    @State private var title: String = "" // 活动标题
    @State private var actText: String = "" // 活动描述
    @ObservedObject var viewModel: ActivitiesViewModel // 活动视图模型
    @State var author: String // 活动作者
    
    @State private var photoPickerItem: PhotosPickerItem? = nil // 选择的图片项目
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title) // 输入活动标题
                TextField("Description", text: $actText) // 输入活动描述
                
                PhotosPicker(selection: $photoPickerItem, matching: .images) { // 选择图片
                    Text("Select Image")
                }
                .onChange(of: photoPickerItem) { newItem in // 当选择的图片改变时
                    Task {
                        if let newItem, let data = try? await newItem.loadTransferable(type: Data.self) {
                            viewModel.selectedImageData = data // 保存选择的图片数据
                        }
                    }
                }
                
                // 显示选择的图片或灰色占位
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
            .navigationTitle("Add Activity") // 设置导航栏标题
            .navigationBarItems(leading: Button("Cancel") { // 取消按钮
                presentationMode.wrappedValue.dismiss() // 关闭视图
            }, trailing: Button("Add") { // 添加按钮
                viewModel.addActivity(title: title, actText: actText, author: author) // 添加活动
                presentationMode.wrappedValue.dismiss() // 关闭视图
            })
        }
    }
}

// 活动列表项视图，显示每个活动的简要信息
struct NewsListItemView: View {
    let newsItem: NewsItem // 活动项
    
    var body: some View {
        VStack(alignment: .leading) {
            // 显示活动图片或占位符
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
            
            // 显示活动标题
            Text(newsItem.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
            
            // 显示活动描述
            if let actText = newsItem.actText {
                Text(actText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            // 显示活动作者
            Text("Author: \(newsItem.author)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

// 活动详情视图，显示活动的详细信息
struct NewsDetailView: View {
    let newsItem: NewsItem // 活动项
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 显示活动图片
                if let imageData = newsItem.imageData, let uiImage = UIImage(data: Data(base64Encoded: imageData)!) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                }
                // 显示活动标题
                Text(newsItem.title)
                    .font(.title)
                // 显示活动描述
                if let actText = newsItem.actText {
                    Text(actText)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                // 显示活动作者
                Text("Author: \(newsItem.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle(newsItem.title) // 设置导航栏标题
    }
}

// 预览代码
#Preview {
    ActivitiesView(author: "John Doe")
}
