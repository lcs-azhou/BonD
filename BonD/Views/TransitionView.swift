//
//  TransitionView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI

struct TransitionView: View {
    @Binding var haschosenlogin: Bool
    @Binding var hasCompletedIntro: Bool
    @Binding var author: String

    var body: some View {
        if hasCompletedIntro == false {
            IntroView(next: $hasCompletedIntro)
        } else {
            LoginView(haschosenlogin: $haschosenlogin, author: $author)
        }
    }
}

#Preview {
    TransitionView(haschosenlogin: .constant(false), hasCompletedIntro: .constant(false), author: .constant(""))
}
