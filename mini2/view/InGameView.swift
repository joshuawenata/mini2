import SwiftUI
import SpriteKit
import SwiftData

struct InGameView: View {
    @StateObject var varManager: VariableManager = VariableManager.shared
    @State private var isHidden: Bool = VariableManager.shared.interactionButtonHidden
    @State private var interactionButtonDestination: String = VariableManager.shared.touchBuilding
    let gameCenter = GameCenterManager.shared    
    @Binding var character: Character

    let scene = GameScene(size: UIScreen.main.bounds.size)
    @Environment (\.presentationMode) var presentationMode
    @Query var quest: [Quest]
    
    var isQuestCompleted: [Bool] {
        let questIDs = [1, 2, 3, 4, 5, 6]
        return questIDs.map { id in
            quest.first(where: { $0.id == id })?.completed ?? false
        }
    }    
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
                
                NavigationLink(destination: destinationView(), label: {
                    Image(imageButton())
                        .resizable()
                        .frame(width: 105, height: 35)
                        .padding(.leading, 200)
                })
                .hidden(
                    VariableManager.shared.interactionButtonHidden ||
                    (VariableManager.shared.touchBuilding == "horse" && isQuestCompleted[0]) ||
                    (VariableManager.shared.touchBuilding == "apple" && isQuestCompleted[1]) ||
                    (VariableManager.shared.touchBuilding == "cat" && isQuestCompleted[2]) ||
                    (VariableManager.shared.touchBuilding == "npcFish" && isQuestCompleted[3]) ||
                    (VariableManager.shared.touchBuilding == "npcFlower" && isQuestCompleted[4]) ||
                    (VariableManager.shared.touchBuilding == "npcHouse" && isQuestCompleted[5])
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

@ViewBuilder
private func destinationView(character: Binding<Character>) -> some View {
        switch VariableManager.shared.touchBuilding {
            case "blacksmith":
                ShopView()
            case "dinerBuilding":
                ShopView()
            case "questBuilding":
                QuestView()
            case "horse":
                QuestFinishedView(id: 1)
            case "apple":
                QuestFinishedView(id: 2)
            case "cat":
                QuestFinishedView(id: 3)
            case "npcFish":
                QuestFinishedView(id: 4)
            case "npcFlower":
                QuestFinishedView(id: 5)
            case "npcHouse":
                QuestFinishedView(id: 6)
            case "sparks", "chest_opened":
                FoundView()
            default:
                EmptyView()
        }
    }

    private func imageButton() -> String {
        switch VariableManager.shared.touchBuilding {
            case "shopBuilding", "dinerBuilding", "npcFish", "npcFlower":
                return "buybutton"
            case "questBuilding", "horse":
                return "interactbutton"
            case "apple":
                return "collectbutton"
            case "cat":
                return "catchbutton"
            case "npcHouse":
                return "chatbutton"
            case "chest_opened":
                return "openbutton"
            case "sparks":
                return "questionmarkbutton"
            default:
                return "interactbutton"
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
