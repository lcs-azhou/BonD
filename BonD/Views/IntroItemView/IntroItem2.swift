//
//  IntroItem2.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-31.
//

import SwiftUI

struct IntroItem2: View {

    var body: some View {
        TabView {
            VStack {
                // 四个正方形视图
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 1), count: 2), spacing: 40) {
                    ForEach(0..<4) { index in
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .frame(height: 320)
                .background(Color(.green.opacity(0.3)))
                .cornerRadius(16)
                .padding()
                .padding()
            }
        }
    }
}

#Preview {
    IntroItem2()
}
