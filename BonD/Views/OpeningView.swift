//
//  OpeningView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI

struct OpeningView: View {
    @State private var haschosenstarted = false
    @State private var haschosenlogin = UserDefaults.standard.bool(forKey: "haschosenlogin")
    @State private var hasCompletedIntro = UserDefaults.standard.bool(forKey: "hasCompletedIntro")
    @State private var author = UserDefaults.standard.string(forKey: "author") ?? ""
    
    var body: some View {
        if haschosenstarted == false {
            StartView(getstarted: $haschosenstarted)
        } else if hasCompletedIntro == false || haschosenlogin == false {
            TransitionView(haschosenlogin: $haschosenlogin, hasCompletedIntro: $hasCompletedIntro, author: $author)
        } else {
            LandingView(haschosenlogin: $haschosenlogin, author: author)
        }
    }
}

#Preview {
    OpeningView()
}
