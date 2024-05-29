//
//  MessageView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI

struct MessageView: View {
    @StateObject private var viewModel = MessagesViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.messages) { message in
                        MessageBubbleView(message: message)
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
        .background(Color.white)
        .padding()
    }
}

#Preview{
    MessageView()
}

