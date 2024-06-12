//
//  MessageBubbleView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI

// 消息气泡视图，用于显示聊天消息
struct MessageBubbleView: View {
    let message: Message // 消息对象
    let isFromCurrentUser: Bool // 是否是当前用户发送的消息
    let profileImageURL: String? // 发送者的头像 URL
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer() // 当前用户的消息靠右显示
                Text(message.message_text)
                    .padding()
                    .background(Color.green.opacity(0.75)) // 绿色背景
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .frame(maxWidth: 250, alignment: .trailing)
                
                Circle()
                    .fill(Color.gray) // 圆形灰色头像占位符
                    .frame(width: 30, height: 30)
                    .padding(.leading, 5)
            } else {
                if let profileImageURL = profileImageURL,
                   let url = URL(string: profileImageURL),
                   let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage) // 显示头像图片
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .padding(.trailing, 5)
                } else {
                    Circle()
                        .fill(Color.gray) // 圆形灰色头像占位符
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 5)
                }
                Text(message.message_text)
                    .padding()
                    .background(Color.white.opacity(0.65)) // 白色背景
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer() // 非当前用户的消息靠左显示
            }
        }
        .padding(5)
    }
}

// 预览代码
#Preview {
    MessageBubbleView(
        message: Message(
            id: 0,
            patron_id: 1,
            message_text: "Hello, this is BonD.",
            chat_room_id: nil
        ),
        isFromCurrentUser: false,
        profileImageURL: nil
    )
}
