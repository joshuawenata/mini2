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
            VStack {
                
                Text("Fall of Aethel")
                    .font(.custom("JollyLodger", size: 100))
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Text("What is your name, adventurer?")
                        .font(.custom("JollyLodger", size: 40))
                    
                    TextField("Enter your name", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .border(Color.black)
                        .frame(width: 400)
                    
                }
                .padding()
                
                Button(action: {
                    presentGameScene()
                }) {
                    Text("Start")
                        .padding()
                        .frame(width: 200)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
            .padding()
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

#Preview {
    OnboardingView()
}
