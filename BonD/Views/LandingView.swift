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
            TodoListView(viewModel: TodoListViewModel())
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

            MessageView(viewModel: MessagesViewModel( chatRoomId: 0))
                .tabItem {
                    Label("Message", systemImage: "ellipsis.message")
                }
        }
        .accentColor(.green)
    }
}

#Preview {
    LandingView(haschosenlogin: .constant(false), author: "John Doe", supabaseClient: supabaseClient)
}
