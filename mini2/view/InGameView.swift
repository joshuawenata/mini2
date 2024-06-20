import SwiftUI
import SpriteKit

struct InGameView: View {
    @StateObject var varManager: VariableManager = VariableManager.shared
    
    @State private var isHidden: Bool = VariableManager.shared.interactionButtonHidden
    
    let scene = GameScene(size: UIScreen.main.bounds.size)
    
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
                
                NavigationLink(destination: ShopView(), label: {
                    Image("InteractButton")
                        .resizable()
                        .frame(width: 105, height: 35)
                        .padding(.leading, 200)
                })
                .hidden(VariableManager.shared.interactionButtonHidden)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        modifier(HiddenModifier(isHidden: shouldHide))
    }
}

struct HiddenModifier: ViewModifier {
    var isHidden: Bool

    func body(content: Content) -> some View {
        content.opacity(isHidden ? 0 : 1)
    }
}

#Preview {
    InGameView()
}
