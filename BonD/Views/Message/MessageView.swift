//
//  MessageView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI

struct MessageView: View {
    @StateObject var viewModel = MessagesViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.messages) { message in
                        // 获取 `patron_id` 以获取 profile_image_url
                        let profileImageURL = getProfileImageURL(for: message.patron_id)
                        MessageBubbleView(message: message, isFromCurrentUser: message.patron_id == 1, profileImageURL: profileImageURL)
                    }
                }
            }
            .padding(.top, 10)
            
            HStack {
                TextField("Message", text: $viewModel.currentMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: viewModel.sendMessage) {
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
        .background{
        Image("Image5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.7)
        }
    }
    
    private func getProfileImageURL(for patronId: Int) -> String? {
        // 获取 profile_image_url 基于 patronId 从您的数据源
        // 这是一个占位实现，您需要根据实际情况实现此功能
        // 例如，通过调用 Supabase 获取 patron 的 profile_image_url
        return "https://example.com/profile.jpg"
    }
}

#Preview {
    MessageView()
}
