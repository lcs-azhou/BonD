//
//  TabViewBasedOnStaticViews.swift
//  SwipeDirectionExample
//
//  Created by Russell Gordon on 2024-05-30.
//

import SwiftUI
import Supabase

struct IntroView: View {
    @State var currentTab: Int = 0
    @Binding var next: Bool
    
    var body: some View {
        VStack {
            TabView(selection: $currentTab) {
                IntroItem1()
                    .tag(0)
                
                IntroItem2()
                    .tag(1)
                
                ZStack {
                    IntroItem3(viewModel: MessagesViewModel(chatRoomId: 1))
                        .tag(2)
                    
                    VStack {
                        Spacer()
                            .frame(height: 500)
                        
                        ZStack {
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .padding(125)
                            
                            Text("Next")
                                .font(.custom("PingFangSC-Thin", size: 45))
                                .foregroundColor(.green.opacity(0.7))
                                .onTapGesture {
                                    next = true
                                    UserDefaults.standard.set(true, forKey: "hasCompletedIntro")
                                }
                        }
                    }
                }
            }
            .background {
                Color.green
                    .opacity(0.45)
                    .ignoresSafeArea()
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    IntroView(next: .constant(false))
}
