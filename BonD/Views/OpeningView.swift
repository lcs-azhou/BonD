//
//  OpeningView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Supabase

struct OpeningView: View {
    @State private var haschosenstarted = false
    @State private var haschosenlogin = UserDefaults.standard.bool(forKey: "haschosenlogin")
    @State private var hasCompletedIntro = UserDefaults.standard.bool(forKey: "hasCompletedIntro")
    @State private var author = UserDefaults.standard.string(forKey: "author") ?? ""
    
    private let supabaseURL = URL(string: "https://ufdspngngqcypdbcorde.supabase.co")!
    private let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmZHNwbmduZ3FjeXBkYmNvcmRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc1MDcyMDAsImV4cCI6MjAzMzA4MzIwMH0.st1h6u9RPDqKGCyJ9Ccvt54lBbrNUWRok8-SO3WvgM8"
    private let supabaseClient: SupabaseClient
    
    init() {
        self.supabaseClient = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    }
    
    var body: some View {
        if haschosenstarted == false {
            StartView(getstarted: $haschosenstarted)
        } else if !hasCompletedIntro || !haschosenlogin {
            TransitionView(haschosenlogin: $haschosenlogin, hasCompletedIntro: $hasCompletedIntro, author: $author)
        } else {
            LandingView(haschosenlogin: $haschosenlogin, author: author, supabaseClient: supabaseClient)
        }
    }
}

#Preview {
    OpeningView()
}
