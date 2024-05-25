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
            .navigationTitle("News")
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
                .frame(height: 150)
                .clipped()
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
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(newsItem.title)
                    .font(.title)
                // Add more content here if needed
            }
            .padding()
        }
        .navigationTitle(newsItem.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let newsItems = [
            NewsItem(title: "Title 1", imageName: "image1"),
            NewsItem(title: "Title 2", imageName: "image2"),
            NewsItem(title: "Title 3", imageName: "image3"),
            NewsItem(title: "Title 4", imageName: "image4")
        ]
        return ActivitiesView(newsItems: newsItems)
    }
}
