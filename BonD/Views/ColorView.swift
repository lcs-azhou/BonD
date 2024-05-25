//
//  ColorView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI

struct ColorView: View {
    var color: Color
    var description: String
    
    var body: some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)
            Text(description)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ColorView(color: .green.opacity(0.5), description: "tab1")
        .tabItem {
            Label("tab1", systemImage: "4.circle")
        }
}
