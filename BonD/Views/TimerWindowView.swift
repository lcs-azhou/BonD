//
//  TimerWindowView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//
import SwiftUI

struct FloatingTimerWindow: View {
    @ObservedObject var viewModel: TimerViewModel
    @State private var position: CGSize = CGSize(width: 100, height: -400)
    @State private var dragOffset: CGSize = .zero
    
    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.formatTime(viewModel.timeRemaining))
                .padding()
                .background(Color.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
        }
        .frame(width: 200, height: 100)
        .background(Color.green.opacity(0.7))
        .cornerRadius(10)
        .shadow(radius: 5)
        .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
        .gesture(DragGesture()
            .onChanged { gesture in
                dragOffset = gesture.translation
            }
            .onEnded { gesture in
                let newPosition = CGSize(width: position.width + gesture.translation.width, height: position.height + gesture.translation.height)
                
                let screenSize = UIScreen.main.bounds.size
                
                let constrainedX = min(max(newPosition.width, 0), screenSize.width - 200)
                let constrainedY = min(max(newPosition.height, 0), screenSize.height - 100)
                
                
                position = CGSize(width: constrainedX, height: constrainedY)
                dragOffset = .zero
            }
        )
    }
}

#Preview {
    FloatingTimerWindow(viewModel: TimerViewModel())
}
