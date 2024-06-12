//
//  IntroItem1.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-31.
//

import SwiftUI

// 介绍项1视图，展示共享待办事项列表的示例
struct IntroItem1: View {
    var body: some View {
        NavigationView {
            List {
                // 列表项
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
            .listStyle(PlainListStyle()) // 设置列表样式
            .background(Color.green.opacity(0.2)) // 设置背景颜色
            .navigationBarTitleDisplayMode(.inline) // 设置导航栏标题显示模式
            .navigationBarItems(leading: HStack {
                Text("Shared Todolist") // 导航栏左侧项目
            })
        }
        .frame(height: 320) // 设置视图高度
        .cornerRadius(16) // 设置视图圆角
        .padding() // 添加内边距
    }
}

// 预览代码
#Preview {
    IntroItem1()
}
