//
//  Activities.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI

struct NewsItem: Identifiable {
    var id = UUID()
    var title: String
    var imageName: String
}

struct ActivitiesView: View {
    let newsItems: [NewsItem]
    
    var body: some View {
        NavigationView {
            List(newsItems) { item in
                NavigationLink(destination: NewsDetailView(newsItem: item)) {
                    NewsListItemView(newsItem: item)
                        .padding(.vertical, 8)
                }
            }
            .navigationTitle("Activities")
        }
    }
}

struct NewsListItemView: View {
    let newsItem: NewsItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(newsItem.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 165)
                .cornerRadius(8.0)
           
            Text(newsItem.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
        }
    }
}

struct NewsDetailView: View {
    let newsItem: NewsItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(newsItem.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                Text(newsItem.title)
                    .font(.title)
    
            }
            .padding()
        }
        .navigationTitle(newsItem.title)
    }
}

#Preview{
    ActivitiesView(newsItems: [NewsItem(title: "Achieve physical and mental relaxation through gentle yoga poses.", imageName: "Image1"),
                   NewsItem(title: "Add some bath salts or essential oils to the hot water to soothe your muscles and relax you at the same time.", imageName: "Image2")])
}
