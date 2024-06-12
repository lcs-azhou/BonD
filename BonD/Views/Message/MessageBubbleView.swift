//
//  MessageBubbleView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: Message
    let isFromCurrentUser: Bool
    let profileImageURL: String?
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.green.opacity(0.75))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .frame(maxWidth: 250, alignment: .trailing)
                
                if let url = profileImageURL, let imageUrl = URL(string: url) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 30, height: 30)
                    }
                    .padding(.leading, 5)
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .padding(.leading, 5)
                }
            } else {
                if let url = profileImageURL, let imageUrl = URL(string: url) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 30, height: 30)
                    }
                    .padding(.trailing, 5)
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 5)
                }
                
                Text(message.text)
                    .padding()
                    .background(Color.white.opacity(0.65))
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer()
            }
        }
        .padding(5)
    }
}

#Preview {
    MessageBubbleView(message: Message(id: 1, text: "Hello, this is BonD.", patron_id: 1), isFromCurrentUser: false, profileImageURL: "https://example.com/profile.jpg")
}
