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
    @State var author: String = ""
    
    var body: some View {
        if haschosennext == false {
            IntroView(next: $haschosennext)
        } else {
            if haschosenlogin == false {
                LoginView(haschosenlogin: $haschosenlogin, author: $author) // 传递绑定变量
            } else {
                LandingView(haschosenlogin: $haschosenlogin, author: author)
            }
        }
    }
}

#Preview {
    TransitionView()
}
