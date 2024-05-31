//
//  TabViewBasedOnStaticViews.swift
//  SwipeDirectionExample
//
//  Created by Russell Gordon on 2024-05-30.
//

import SwiftUI

struct TabViewBasedOnStaticViews: View {
    
    // MARK: Stored properties
    
    // Keep track of what tab we are currently on
    @State var currentTab: Int = 0
    
    // Report on the swipe direction, once a swipe occurs
    @State var swipeDirection: String = ""
    
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
                
                IntroItem3()
                    .tag(2)

            }
            // Present the tab view
            .tabViewStyle(.page)
            // Always show the dots to indicate available pages
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
        }
    }
}
#Preview {
    TabViewBasedOnStaticViews()
}
