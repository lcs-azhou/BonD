//
//  SharedAlbum.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI

struct SharedAlbum: View {
    let items = Array(1...20) 
    @State private var isSheetPresented = false

    var body: some View {
        List {
            Button(action: {
                            isSheetPresented.toggle()
                        }) {
                                Text("Add photo to the Shared Album")
                                    .foregroundColor(.green)
                        }
                        .padding()
                        .sheet(isPresented: $isSheetPresented) {
                            SheetView()
                        }
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

struct SheetView: View {
    var body: some View {
        VStack {
            Text("Add photo to the Shared Album")
                .presentationDetents([.medium,.fraction(0.35)])
                .padding()
        }
    }
}

#Preview {
    SharedAlbum()
}
