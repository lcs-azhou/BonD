//
//  IntroItem2.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-31.
//

import SwiftUI

// 介绍项2视图，展示四个正方形视图的示例
struct IntroItem2: View {

    var body: some View {
        TabView {
            VStack {
                // 使用 LazyVGrid 布局四个正方形视图
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 1), count: 2), spacing: 40) {
                    ForEach(0..<4) { index in
                        Rectangle()
                            .fill(Color.green) // 设置正方形的填充颜色为绿色
                            .frame(width: 100, height: 100) // 设置正方形的大小
                            .cornerRadius(8) // 设置正方形的圆角
                    }
                }
                .padding()
                .frame(height: 320) // 设置网格视图的高度
                .background(Color.green.opacity(0.3)) // 设置背景颜色并调整透明度
                .cornerRadius(16) // 设置视图的圆角
                .padding()
            }
        }
    }
}

// 预览代码
#Preview {
    IntroItem2()
}
