//
//  ActivitiesViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Supabase

@MainActor
class ActivitiesViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []
    @Published var selectedImageData: Data?

    // 添加活动
    func addActivity(title: String, actText: String?, author: String) {
        let imageDataString = selectedImageData?.base64EncodedString()
        let newItem = NewsItem(id: UUID().uuidString, title: title, imageData: imageDataString, actText: actText, author: author)
        newsItems.append(newItem)
        saveActivityToSupabase(newItem)
        selectedImageData = nil
    }

    // 将活动保存到 Supabase
    private func saveActivityToSupabase(_ item: NewsItem) {
        Task {
            do {
                let _ = try await supabaseClient
                    .from("activities")
                    .insert([item])
                    .execute()
                print("Activity saved to Supabase")
            } catch {
                print("Error saving activity to Supabase: \(error)")
            }
        }
    }

    // 加载活动
    func loadActivities() {
        Task {
            do {
                let response: [NewsItem] = try await supabaseClient
                    .from("activities")
                    .select()
                    .execute()
                    .value
                self.newsItems = response
            } catch {
                print("Error loading activities from Supabase: \(error)")
            }
        }
    }
}
