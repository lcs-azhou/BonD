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

    @StateObject var viewModel: TimerViewModel

    init(haschosenlogin: Binding<Bool>, author: String, supabaseClient: SupabaseClient) {
        self._haschosenlogin = haschosenlogin
        self.author = author
        self._viewModel = StateObject(wrappedValue: TimerViewModel(supabaseClient: supabaseClient, taskId: 1))
    }

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

            MessageView(viewModel: MessagesViewModel(supabaseClient: viewModel.supabaseClient, chatRoomId: 0))
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
    let supabaseURL = URL(string: "https://ufdspngngqcypdbcorde.supabase.co")!
    let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmZHNwbmduZ3FjeXBkYmNvcmRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc1MDcyMDAsImV4cCI6MjAzMzA4MzIwMH0.st1h6u9RPDqKGCyJ9Ccvt54lBbrNUWRok8-SO3WvgM8"
    let supabaseClient = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    return LandingView(haschosenlogin: .constant(false), author: "John Doe", supabaseClient: supabaseClient)
}
