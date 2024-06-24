import SwiftUI
import SpriteKit

struct InGameView: View {

    @StateObject var varManager: VariableManager = VariableManager.shared
    
    @State private var isHidden: Bool = VariableManager.shared.interactionButtonHidden
    @State private var interactionButtonDestination: String = VariableManager.shared.touchBuilding

    let gameCenter = GameCenterManager.shared

    
    @State var character: Character = Character()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if gameCenter.jungleView {
                    SpriteView(scene: GameScene(size: UIScreen.main.bounds.size, character:character)).ignoresSafeArea()
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
                                
                                NavigationLink(destination: CharacterView(character: $character), label: {
                                    Image("character")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.leading, 20)
                                })
                                
                                NavigationLink(destination: BackpackView(character: $character), label: {
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
                
                NavigationLink(destination: destinationView(character: $character), label: {
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

@ViewBuilder
private func destinationView(character: Binding<Character>) -> some View {
        switch VariableManager.shared.touchBuilding {
        case "shopBuilding":
            ShopView(character: character)
        case "dinerBuilding":
            ShopView(character: character)
        case "questBuilding":
            QuestView()
        default:
            EmptyView()
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
