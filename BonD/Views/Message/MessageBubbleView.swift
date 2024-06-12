//
//  MessageBubbleView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

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
                Text(message.message_text)
                    .padding()
                    .background(Color.green.opacity(0.75))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .frame(maxWidth: 250, alignment: .trailing)
                
                Circle()
                    .fill(Color.gray)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 5)
            } else {
                if let profileImageURL = profileImageURL, let url = URL(string: profileImageURL), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .padding(.trailing, 5)
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 5)
                }
                Text(message.message_text)
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
    MessageBubbleView(message: Message(id: 0, patron_id: 1, message_text: "Hello, this is BonD.", chat_room_id: nil, isFromCurrentUser: false), isFromCurrentUser: false, profileImageURL: nil)
}
