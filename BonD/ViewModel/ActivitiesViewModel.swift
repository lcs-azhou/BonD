//
//  ActivitiesViewModel.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Supabase

class ActivitiesViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []
    @Published var selectedImageData: Data?

    init() {
        loadActivities()
    }

    func addActivity(title: String) {
        let imageDataString = selectedImageData?.base64EncodedString()
        let newItem = NewsItem(id: UUID().uuidString, title: title, imageData: imageDataString)
        newsItems.append(newItem)
        saveActivityToSupabase(newItem)
        selectedImageData = nil
    }

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

    private func loadActivities() {
        Task {
            do {
                let response: [NewsItem] = try await supabaseClient
                    .from("activities")
                    .select()
                    .execute()
                    .value
                DispatchQueue.main.async {
                    self.newsItems = response
                }
            } catch {
                print("Error loading activities from Supabase: \(error)")
            }
        }
    }
}
