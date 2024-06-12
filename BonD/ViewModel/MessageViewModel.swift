//
//  MessagesViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import Foundation
import Combine
import Supabase

class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var currentMessage: String = ""
    
    private var supabaseClient: SupabaseClient
    private var chatRoomId: Int
    
    init(supabaseClient: SupabaseClient, chatRoomId: Int) {
        self.supabaseClient = supabaseClient
        self.chatRoomId = chatRoomId
        loadMessages()
    }
    
    func sendMessage() {
        guard !currentMessage.isEmpty else { return }
        let newMessage = Message(id: 0, text: currentMessage, patron_id: 1, isFromCurrentUser: true)  // Update patron_id appropriately
        messages.append(newMessage)
        currentMessage = ""
        saveMessageToSupabase(newMessage)
    }
    
    private func saveMessageToSupabase(_ message: Message) {
        Task {
            do {
                var encodedMessage = message
                let _ = try await supabaseClient
                    .from("message")
                    .insert(encodedMessage)
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
                DispatchQueue.main.async {
                    self.messages = response
                }
            } catch {
                print("Error loading messages from Supabase: \(error)")
            }
        }
    }
}
