//
//  LandingView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        @StateObject var viewModel = TimerViewModel()
        
        TabView {
            TodoList()
                .tabItem {
                    Label("Todos", systemImage: "checklist")
                }
            
            SharedAlbum()
                .tabItem {
                    Label("Album", systemImage: "person.2.crop.square.stack")
                }
            
            ActivitiesView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            MessageView()
                .tabItem {
                    Label("Message", systemImage: "ellipsis.message")
                }
        }.accentColor(.green)
            .overlay(
                FloatingTimerWindow(viewModel: viewModel)
            )
    }
}


#Preview {
    LandingView()
}
