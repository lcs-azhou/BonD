//
//  OpeningView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI
import Supabase

struct OpeningView: View {
    @State private var haschosenstarted = false
    @AppStorage("haschosenlogin") private var haschosenlogin = false
    @AppStorage("hasCompletedIntro") private var hasCompletedIntro = false
    @AppStorage("author") private var author: String = ""
    
    var body: some View {
        if !haschosenstarted {
            StartView(getstarted: $haschosenstarted)
        } else if !hasCompletedIntro || !haschosenlogin {
            TransitionView(hasChosenLogin: $haschosenlogin, hasCompletedIntro: $hasCompletedIntro, author: $author)
        } else {
            LandingView(hasChosenLogin: $haschosenlogin, author: author, supabaseClient: supabaseClient)
        }
    }
}

#Preview {
    OpeningView()
}
