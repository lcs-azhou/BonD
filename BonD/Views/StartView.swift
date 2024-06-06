//
//  StartView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI

struct StartView: View {
   
    @Binding var getstarted: Bool
    
    var body: some View {
        ZStack{
            Image("Image5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack {
                Text("BonD")
                    .font(
                        .custom("PingFangSC-Thin", size: 130)
                    )
                    .foregroundStyle(.green.opacity(0.7))
                Spacer()
                Text("Get Started")
                    .font(
                        .custom("PingFangSC-Thin", size: 45)
                    )
                    .foregroundStyle(.green.opacity(0.7))
                    .onTapGesture {
                        getstarted = true
                    }
            }
        }
    }
}

#Preview {
    StartView(getstarted: Binding.constant(false))
}
