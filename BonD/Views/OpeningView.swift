//
//  OpeningView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-06.
//

import SwiftUI

struct OpeningView: View {
    @State private var haschosenstarted = false
    
    var body: some View {
        if haschosenstarted == false {
            StartView(getstarted: $haschosenstarted)
        } else {
            IntroView()
        }
    }
}

#Preview {
    OpeningView()
}
