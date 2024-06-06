//
//  TransitionView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI

struct TransitionView: View {
    @State var haschosennext = false
    
    var body: some View {
        if haschosennext == false {
            IntroView(next:$haschosennext)
        } else {
            LandingView()
        }
    }
}

#Preview {
    TransitionView()
}
