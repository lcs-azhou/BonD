//
//  TimerWindowView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//
import SwiftUI

struct FloatingTimerWindow: View {
    @ObservedObject var viewModel: TimerViewModel // Use @ObservedObject for observing changes
    init(viewModel: TimerViewModel) {
            self.viewModel = viewModel
        }
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.formatTime(viewModel.timeRemaining)) // Display remaining time from viewModel
                .padding()
                .background(Color.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .onReceive(viewModel.$timeRemaining) { _ in
                    // Refresh UI when timeRemaining changes
                }
        }
        .frame(width: 200, height: 100)
        .background(Color.green.opacity(0.7))
        .cornerRadius(10)
        .shadow(radius: 5)
        .offset(x: 100, y: -400)
        .gesture(DragGesture()
                    .onChanged { gesture in
                        // Handle dragging
                    }
                    .onEnded { _ in
                        // Handle dragging end
                    }
        )
    }
}

#Preview{
    FloatingTimerWindow(viewModel: TimerViewModel())
}
