//
//  OnboardingView.swift
//  mini2
//
//  Created by Timothy Andrian on 06/06/24.
//

import SwiftUI
import SpriteKit

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bgLandingPage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Text("Fall of Aethel")
                .font(.custom("JollyLodger", size: 80))
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                        .padding(.top, 50)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("What is your name, adventurer?")
                            .font(.custom("JollyLodger", size: 50))
                            .foregroundColor(.white)
                            .frame(height: 50)
                        
                        ZStack {
                            Image("textbox")
                                .resizable()
                                .frame(width: 500, height: 80)
                                .scaledToFit()
                            
                            TextField("Enter your name", text: .constant(""))
                                .padding()
                                .frame(width: 400)
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        presentGameScene()
                    }) {
                        Image("startbutton")
                            .resizable()
                            .frame(width: 250, height: 70)
                    }
                }
            }
        }
    }
    
    func presentGameScene() {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        let gameView = SpriteView(scene: scene).ignoresSafeArea()

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        windowScene.windows.first?.rootViewController?.present(
            UIHostingController(rootView: gameView), animated: true)
    }
}

