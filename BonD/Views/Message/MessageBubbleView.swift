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
                    .background(Color.blue)
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
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer()
            }
        }
        .padding(.vertical, 5)
    }
}


struct MessageBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageBubbleView(message: Message(text: "Hello,thia is BonD.", isFromCurrentUser: false))
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Received Message")
            
            MessageBubbleView(message: Message(text: "Hi,introduce me the app.", isFromCurrentUser: true))
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Sent Message")
        }
    }
}
