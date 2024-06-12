//
//  MessageView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI
import Supabase

// 消息视图，显示聊天消息并提供发送消息的功能
struct MessageView: View {
    @StateObject var viewModel: MessagesViewModel // 观察的消息视图模型对象

    var body: some View {
        VStack {
            // 显示消息的滚动视图
            ScrollView {
                VStack {
                    // 遍历并显示每条消息
                    ForEach(viewModel.messages) { message in
                        MessageBubbleView(message: message, isFromCurrentUser: message.isFromCurrentUser, profileImageURL: nil)
                    }
                }
            }
            .padding(.top, 10)
            
            // 消息输入和发送按钮
            HStack {
                TextField("Message", text: $viewModel.currentMessage) // 消息输入框
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: viewModel.sendMessage) { // 发送按钮
                    Text("Send")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .background {
            Image("Image5") // 背景图片
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.7)
        }
    }
}

// 预览代码
#Preview {
    MessageView(viewModel: MessagesViewModel(chatRoomId: 0))
}
