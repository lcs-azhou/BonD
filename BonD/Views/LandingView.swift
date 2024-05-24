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
            ColorView(color: .green.opacity(0.4), description: "tab1")
                .tabItem {
                    Label("tab1", systemImage: "1.circle")
                }
            
            ColorView(color: .gray.opacity(0.3), description: "tab2")
                .tabItem {
                    Label("tab2", systemImage: "2.circle")
                }
            
            ColorView(color: .yellow, description: "tab3")
                .tabItem {
                    Label("tab3", systemImage: "3.circle")
                }
            
            ColorView(color: .green.opacity(0.5), description: "tab4")
                .tabItem {
                    Label("tab4", systemImage: "4.circle")
                }
        }
    }
}



#Preview {
    LandingView()
}
