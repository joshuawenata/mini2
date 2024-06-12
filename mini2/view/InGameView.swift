import SwiftUI
import SpriteKit

struct InGameView: View {
    let scene = GameScene(size: UIScreen.main.bounds.size)
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                SpriteView(scene: scene).ignoresSafeArea()
                
                VStack {
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: CharacterView(), label: {
                                Image("character")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                            })
                            
                            NavigationLink(destination: EmptyView(), label: {
                                Image("inventory")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                            })
                            
                            NavigationLink(destination: EmptyView(), label: {
                                Image("exit")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
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

