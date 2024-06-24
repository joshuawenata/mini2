import Foundation
import SpriteKit

func startBossAnimation(bossNode: SKSpriteNode?) {
    var bossTexture: [SKTexture] = []
    
    for i in 0...15 {
        let textureName = String(format: "bossAttack_%05d", i)
        let texture = SKTexture(imageNamed: textureName)
        bossTexture.append(texture)
    }
    
    let bossAnimation = SKAction.animate(with: bossTexture, timePerFrame: 0.1, resize: false, restore: true)
    let repeatBoss = SKAction.repeatForever(bossAnimation)
    bossNode?.run(repeatBoss, withKey: "boss")
}
