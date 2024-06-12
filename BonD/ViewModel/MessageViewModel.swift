//
//  MessageViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI
import Combine
import Supabase

class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var currentMessage: String = ""
    @Published var profileImageURLs: [Int: String] = [:]
    
    func sendMessage() {
        guard !currentMessage.isEmpty else { return }
        let newMessage = Message(id: nil, text: currentMessage, patron_id: 1) // 使用正确的 patron_id
        saveMessageToSupabase(newMessage)
        currentMessage = ""
    }
    
    private func saveMessageToSupabase(_ message: Message) {
        Task {
            do {
                let _ = try await supabaseClient
                    .from("message")
                    .insert([message])
                    .execute()
                await loadMessages()
            } catch {
                print("Error saving message to Supabase: \(error)")
            }
        }
    }
    
    func loadMessages() {
        Task {
            do {
                let response: [Message] = try await supabaseClient
                    .from("message")
                    .select()
                    .execute()
                    .value
                DispatchQueue.main.async { [weak self] in
                    self?.messages = response
                    self?.loadProfileImages()
                }
            } catch {
                print("Error loading messages from Supabase: \(error)")
            }
        }
    }
    
    private func loadProfileImages() {
        Task {
            for message in messages {
                if profileImageURLs[message.patron_id] == nil {
                    let profileImageURL = await getProfileImageURL(for: message.patron_id)
                    DispatchQueue.main.async { [weak self] in
                        self?.profileImageURLs[message.patron_id] = profileImageURL
                    }
                }
            }
        }
    }
    
    func getProfileImageURL(for patronId: Int) async -> String? {
        do {
            let response: [Patron] = try await supabaseClient
                .from("patron")
                .select()
                .eq("id", value: patronId)
                .execute()
                .value
            return response.first?.profile_image_url
        } catch {
            print("Error getting profile image URL: \(error)")
            return nil
        }
    }
}
