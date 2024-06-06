//
//  MessageBubbleView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-25.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                Text(message.text)
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
                
                Circle()
                    .fill(Color.gray) 
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 5)
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

#Preview{
    MessageBubbleView(message: Message(text: "Hello,this is BonD.", isFromCurrentUser: false))
}
