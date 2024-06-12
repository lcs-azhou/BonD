//
//  IntroItem3.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-31.
//

import SwiftUI
import Supabase

// 介绍项3视图，展示消息气泡视图的示例
struct IntroItem3: View {
    @StateObject var viewModel: MessagesViewModel // 观察的消息视图模型对象

    var body: some View {
        VStack {
            // 遍历并显示每条消息
            ForEach(viewModel.messages) { message in
                // 获取发送者的头像 URL
                let profileImageURL = viewModel.getProfileImageURL(for: message.patron_id)
                // 显示消息气泡视图
                MessageBubbleView(
                    message: message,
                    isFromCurrentUser: message.patron_id == 1, // 判断消息是否来自当前用户
                    profileImageURL: profileImageURL
                )
            }
            .padding()
        }
        .frame(height: 320) // 设置视图高度
        .background(Color.green.opacity(0.3)) // 设置背景颜色并调整透明度
        .cornerRadius(16) // 设置视图的圆角
        .padding()
    }
}

// 预览代码
#Preview {
    IntroItem3(viewModel: MessagesViewModel(chatRoomId: 1))
}
