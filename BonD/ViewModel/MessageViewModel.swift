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
        Message(text: "Hello,this is BonD.", isFromCurrentUser: false),
        Message(text: "Hi,introduce me the app.", isFromCurrentUser: true)
    ]
    
    @Published var currentMessage: String = ""
    
    func sendMessage() {
        guard !currentMessage.isEmpty else { return }
        let newMessage = Message(text: currentMessage, isFromCurrentUser: true)
        messages.append(newMessage)
        currentMessage = ""
    }
}
