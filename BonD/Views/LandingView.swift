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
                    Label("tab1", systemImage: "1.circle")
                }

            SharedAlbum()
                .tabItem {
                    Label("tab2", systemImage: "2.circle")
                }
            
            ActivitiesView(newsItems: [NewsItem(title: "Title 1", imageName: "image1"),
                                       NewsItem(title: "Title 2", imageName: "image2"),
                                       NewsItem(title: "Title 3", imageName: "image3"),
                                       NewsItem(title: "Title 4", imageName: "image4")])
                .tabItem {
                    Label("tab3", systemImage: "2.circle")
                }
            
            MessageView()
                .tabItem {
                    Label("tab4", systemImage: "4.circle")
                }
        }
    }
}


#Preview {
    LandingView()
}
