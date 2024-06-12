//
//  LandingView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI
import Supabase

struct LandingView: View {
    @Binding var haschosenlogin: Bool
    var author: String

    @StateObject var viewModel = TimerViewModel()

    var body: some View {
        TabView {
            TodoList()
                .tabItem {
                    Label("Todos", systemImage: "checklist")
                }

            SharedAlbum()
                .tabItem {
                    Label("Album", systemImage: "person.2.crop.square.stack")
                }

            ActivitiesView(author: author)
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }

            let supabaseClient = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
            MessageView(viewModel: MessagesViewModel(supabaseClient: supabaseClient, chatRoomId: 0))
                .tabItem {
                    Label("Message", systemImage: "ellipsis.message")
                }
        }
        .accentColor(.green)
        .overlay(
            FloatingTimerWindow(viewModel: viewModel)
        )
    }
}

#Preview {
    let supabaseClient = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    return LandingView(haschosenlogin: .constant(false), author: "John Doe")
}
