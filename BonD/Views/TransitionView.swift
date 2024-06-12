//
//  TransitionView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI

struct TransitionView: View {
    @Binding var hasChosenLogin: Bool
    @Binding var hasCompletedIntro: Bool
    @Binding var author: String

    var body: some View {
        Group {
            if !hasCompletedIntro {
                IntroView(next: $hasCompletedIntro)
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    TransitionView(hasChosenLogin: .constant(false), hasCompletedIntro: .constant(false), author: .constant(""))
}
