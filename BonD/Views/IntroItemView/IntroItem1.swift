//
//  IntroItem1.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-31.
//

import SwiftUI

struct IntroItem1: View {
    var body: some View {
        TabView {
            NavigationView {
                List {
                    // List items
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
                .listStyle(PlainListStyle())
                .background(Color.green.opacity(0.2))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: HStack {
                    Text("Shared Todolist")
                })
            }
            .frame(height: 320)
            .cornerRadius(16)
            .padding()
            .padding()
        }
    }
}

#Preview {
    IntroItem1()
}
