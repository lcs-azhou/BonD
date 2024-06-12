//
//  MessagesViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import Foundation
import Combine
import Supabase

@MainActor // 确保在主线程上执行
class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = [] // 存储消息的数组
    @Published var currentMessage: String = "" // 当前输入的消息

    private var chatRoomId: Int

    init(chatRoomId: Int) {
        self.chatRoomId = chatRoomId
        loadMessages()
    }
    
    func sendMessage() {
        guard !currentMessage.isEmpty else { return }
        let newMessage = Message(id: 0, patron_id: 1, message_text: currentMessage, chat_room_id: chatRoomId)
        messages.append(newMessage)
        currentMessage = ""
        saveMessageToSupabase(newMessage)
    }
    
    private func saveMessageToSupabase(_ message: Message) {
        Task {
            do {
                let _ = try await supabaseClient
                    .from("message")
                    .insert(message)
                    .execute()
                loadMessages()
            } catch {
                print("Error saving message to Supabase: \(error)")
            }
        }
    }
    
    private func loadMessages() {
        Task {
            do {
                let response: [Message] = try await supabaseClient
                    .from("message")
                    .select()
                    .execute()
                    .value
                self.messages = response
            } catch {
                print("Error loading messages from Supabase: \(error)")
            }
        }
    }
    
    func getProfileImageURL(for patronId: Int) -> String? {
        // 实现获取指定 patron ID 的头像 URL 的逻辑
        return nil // 替换为实际实现
    }
}
