//
//  PopUpView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-28.
//

import SwiftUI

struct PopUpView: View {
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Button("Share with members in your group.") {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Share"),
                    message: Text("Do you want to share your todolist with your group members?"),
                    primaryButton: .default(Text("Yes"), action: {
                        print("shared")
                    }),
                    secondaryButton: .cancel(Text("Cancel"), action: {
                        print("canceled")
                    })
                )
            }
        }
        .padding()
    }
}

#Preview{
    PopUpView()
}
