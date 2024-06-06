//
//  ActivitiesViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import PhotosUI

class ActivitiesViewModel: ObservableObject {
    @Published var newsItems: [NewsItem]
    @Published var selectedImageData: Data?
    
    init(newsItems: [NewsItem] = []) {
        self.newsItems = newsItems
    }
    
    func addActivity(title: String) {
        let newItem = NewsItem(title: title, imageData: selectedImageData)
        newsItems.append(newItem)
        selectedImageData = nil
    }
}
