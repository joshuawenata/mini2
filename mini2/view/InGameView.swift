import SwiftUI
import SpriteKit

struct InGameView: View {
    let gameCenter = GameCenterManager()
    let scene = GameScene(size: UIScreen.main.bounds.size)
    
    var body: some View {
        NavigationStack {
            ZStack {
                if gameCenter.jungleView {
                    SpriteView(scene: scene).ignoresSafeArea()
                }

                VStack {
                    VStack {
                        HStack {
                            Spacer()
                            if !gameCenter.battleView {
                                NavigationLink(destination: LeaderboardView(), label: {
                                    Image("leaderboard")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.black)
                                })
                                
                                NavigationLink(destination: CharacterView(), label: {
                                    Image("character")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.leading, 20)
                                })
                                
                                NavigationLink(destination: BackpackView(), label: {
                                    Image("inventory")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.leading, 20)
                                })
                                
                                NavigationLink(destination: OptionView(), label: {
                                    Image("option")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.leading, 20)
                                })
                            }
                        }
                    }
                    
                    Spacer()
                    
                }
                .padding(.top, 20)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

