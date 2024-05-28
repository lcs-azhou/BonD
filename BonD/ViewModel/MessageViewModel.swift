//
//  MessageViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI
import Combine

class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(text: "Hello!", isFromCurrentUser: false),
        Message(text: "Hi, how are you?", isFromCurrentUser: true),
        Message(text: "I'm good, thanks!", isFromCurrentUser: false),
        Message(text: "Great to hear!", isFromCurrentUser: true)
    ]
    
    @Published var currentMessage: String = ""
    
    func sendMessage() {
        guard !currentMessage.isEmpty else { return }
        let newMessage = Message(text: currentMessage, isFromCurrentUser: true)
        messages.append(newMessage)
        currentMessage = ""
    }
}
