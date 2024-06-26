import Foundation
import SpriteKit

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max) * (max - min) + min
}

func addRandomSparks(addChild: (SKNode) -> Void) {
    let sparksPosition = CGPoint(x: random(min: -2500, max: -1500), y: random(min: 500, max: 1000))
    let sparks = addBuilding(at: sparksPosition, imageName: "sparks")
    
    addChild(sparks)
}

func addRandomChest(addChild: (SKNode) -> Void) {
    let chestPosition = CGPoint(x: random(min: -2500, max: -2000), y: random(min: -200, max: 300))
    let chest = addBuilding(at: chestPosition, imageName: "chest_opened")
    
    addChild(chest)
}
