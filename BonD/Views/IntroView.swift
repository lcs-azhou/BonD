//
//  TabViewBasedOnStaticViews.swift
//  SwipeDirectionExample
//
//  Created by Russell Gordon on 2024-05-30.
//

import SwiftUI

struct IntroView: View {
    
    // MARK: Stored properties
    
    // Keep track of what tab we are currently on
    @State var currentTab: Int = 0
    
    // Report on the swipe direction, once a swipe occurs
    @State var swipeDirection: String = ""
    
    @Binding var next: Bool
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            // Show a tab view
            //
            // The TabView will updated $currentTab with the tag of whatever page is currently selected
            TabView(selection: $currentTab) {

                IntroItem1()
                    .tag(0)
                
                IntroItem2()
                    .tag(1)
                
                ZStack {
                    IntroItem3()
                        .tag(2)
                    VStack {
                        Spacer()
                            .frame(height:500)
                        ZStack {
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .frame(height:50)
                                .padding(125)
                            Text("Next")
                                .font(
                                    .custom("PingFangSC-Thin", size: 45)
                                )
                                .foregroundStyle(.green.opacity(0.7))
                                .onTapGesture {
                                    next = true
                            }
                        }
                    }
                }

            }
            .background{
                Color(.green)
                    .opacity(0.45)
                    .ignoresSafeArea()
            }
            // Present the tab view
            .tabViewStyle(.page)
            // Always show the dots to indicate available pages
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
        }
    }
}
#Preview {
    IntroView(next: Binding.constant(false))
}
