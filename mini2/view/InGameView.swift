import SwiftUI
import SpriteKit

struct InGameView: View {
    let scene = BattleScene(size: UIScreen.main.bounds.size)
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                SpriteView(scene: scene).ignoresSafeArea()
                
                VStack {
                    VStack {
                        HStack {
                            Spacer()
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
                    
                    Spacer()
                    
                }
                .padding(.top, 20)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

