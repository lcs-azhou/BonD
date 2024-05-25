//
//  SharedAlbum.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI

struct SharedAlbum: View {
    let items = Array(1...20) 

    var body: some View {
        List {
            ForEach(0..<items.count / 2, id: \.self) { rowIndex in
                HStack(spacing: 16) {
                    ForEach(0..<2, id: \.self) { colIndex in
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.green.opacity(0.4))
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

#Preview {
    SharedAlbum()
}
