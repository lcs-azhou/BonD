//
//  IntroItem3.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-31.
//

import SwiftUI

struct IntroItem3: View {
    @StateObject var viewModel = MessagesViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.messages) { message in
                let profileImageURL = viewModel.profileImageURLs[message.patron_id]
                MessageBubbleView(message: message, isFromCurrentUser: message.patron_id == 1, profileImageURL: profileImageURL)
            }
            .padding()
        }
        .frame(height: 320)
        .background(Color(.green.opacity(0.3)))
        .cornerRadius(16)
        .padding()
        .padding()
    }
}

#Preview {
    TabView {
        IntroItem3()
    }
}
