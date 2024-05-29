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
            
            ActivitiesView(newsItems: [NewsItem(title: "Achieve physical and mental relaxation through gentle yoga poses.", imageName: "Image1"),
                                       NewsItem(title: "Add some bath salts or essential oils to the hot water to soothe your muscles and relax you at the same time.", imageName: "Image2"),
                                      NewsItem(title: "Participating in some volunteer activities and helping others can also bring inner satisfaction and joy.", imageName: "Image3"),
                                      NewsItem(title: "Go camping on weekends or vacations with family or friends and enjoy the serenity of outdoor living.", imageName: "Image4")])
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
