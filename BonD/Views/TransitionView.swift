//
//  TransitionView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI

struct TransitionView: View {
    @State var haschosennext = false
    @State var haschosenlogin = false
    
    var body: some View {
        if haschosennext == false {
            IntroView(next:$haschosennext)
        } else {
            if haschosenlogin == false{
                LoginView()
            } else{
                LandingView()
            }
        }
    }
}

#Preview {
    TransitionView()
}
