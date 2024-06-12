//
//  MessageView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI
import Supabase

struct MessageView: View {
    @StateObject var viewModel: MessagesViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.messages) { message in
                        MessageBubbleView(message: message, isFromCurrentUser: message.isFromCurrentUser, profileImageURL: nil)
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
        .background {
            Image("Image5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.7)
        }
    }
}

#Preview {
    let supabaseClient = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    return MessageView(viewModel: MessagesViewModel(supabaseClient: supabaseClient, chatRoomId: 0))
}
