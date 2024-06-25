//
//  OnboardingView.swift
//  mini2
//
//  Created by Timothy Andrian on 06/06/24.
//

import SwiftUI
import SpriteKit

struct OnboardingView: View {
    let gameCenter = GameCenterManager.shared
    @State var character: Character = Character()
    @State private var currentFrame: Int = 0
        private let totalFrames = 16

        var body: some View {
            NavigationStack {
                ZStack {
                    NavigationLink(destination: InGameView(character: $character), label: {
                        Image("onboarding_\(String(format: "%05d", currentFrame))")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .edgesIgnoringSafeArea(.all)
                    })
                }
            }
            .onAppear {
                // Start animating frames
                animateFrames()
            }
        }
        
        private func animateFrames() {
            // Create a repeating timer to advance frames
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.currentFrame = (self.currentFrame + 1) % self.totalFrames
            }
        }
}

