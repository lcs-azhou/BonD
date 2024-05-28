//
//  LandingView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI

struct LandingView: View {
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
            
            ActivitiesView(newsItems: [NewsItem(title: "Title 1", imageName: "image1"),
                                       NewsItem(title: "Title 2", imageName: "image2"),
                                       NewsItem(title: "Title 3", imageName: "image3"),
                                       NewsItem(title: "Title 4", imageName: "image4")])
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            MessageView()
                .tabItem {
                    Label("Message", systemImage: "ellipsis.message")
                }
        }
    }
}


#Preview {
    LandingView()
}
