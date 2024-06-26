//
//  buildingViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 11/06/24.
//

import Foundation
import SpriteKit

func addBuilding(at position: CGPoint, imageName: String, isRectangle: Bool = false) -> SKSpriteNode {
    let building = SKSpriteNode(imageNamed: imageName)
    if isRectangle {
        building.physicsBody = SKPhysicsBody(rectangleOf: building.size)
    } else {
        let texture = SKTexture(imageNamed: imageName)
        building.physicsBody = SKPhysicsBody(texture: texture, size: building.size)
    }
    building.position = position
    building.name = imageName
    building.setScale(0.2)
    building.zPosition = -1
    building.physicsBody?.affectedByGravity = false
    building.physicsBody?.allowsRotation = false
    building.physicsBody?.categoryBitMask = CollisionCategory.building.rawValue
    building.physicsBody?.collisionBitMask = CollisionCategory.building.rawValue
    building.physicsBody?.contactTestBitMask = CollisionCategory.building.rawValue
    building.physicsBody?.isDynamic = false
    
    return building
}

func addBuildingWithoutPhysics(at position: CGPoint, imageName: String) -> SKSpriteNode {
    let building = SKSpriteNode(imageNamed: imageName)
    building.position = position
    building.name = imageName
    building.setScale(0.2)
    building.zPosition = -1
    
    return building
}

func startBlacksmithAnimation(blacksmithNode: SKSpriteNode?) {
    var blacksmithTexture: [SKTexture] = []
            
    for i in 0...29 {
        let textureName = String(format: "blacksmith_%05d", i)
        let texture = SKTexture(imageNamed: textureName)
        blacksmithTexture.append(texture)
    }
    
    let blacksmithAnimation = SKAction.animate(with: blacksmithTexture, timePerFrame: 0.05, resize: false, restore: true)
    let repeatBlacksmith = SKAction.repeatForever(blacksmithAnimation)
    blacksmithNode?.run(repeatBlacksmith, withKey: "blacksmith")
}

func startHorseAnimation(horseNode: SKSpriteNode?) {
    var horseTexture: [SKTexture] = []
    
    for i in 0...29 {
        let textureName = String(format: "horse_%05d", i)
        let texture = SKTexture(imageNamed: textureName)
        horseTexture.append(texture)
    }
    
    let horseAnimation = SKAction.animate(with: horseTexture, timePerFrame: 0.05, resize: false, restore: true)
    let repeatHorse = SKAction.repeatForever(horseAnimation)
    horseNode?.run(repeatHorse, withKey: "horse")
}

func startRiverAnimation(riverNode: SKSpriteNode?) {
    var riverTexture: [SKTexture] = []
    
    for i in 1...4 {
        let textureName = String(format: "river%d", i)
        let texture = SKTexture(imageNamed: textureName)
        riverTexture.append(texture)
    }
    
    let riverAnimation = SKAction.animate(with: riverTexture, timePerFrame: 0.1, resize: false, restore: true)
    let repeatRiver = SKAction.repeatForever(riverAnimation)
    riverNode?.run(repeatRiver, withKey: "river")
}

func startCatAnimation(catNode: SKSpriteNode?) {
    var catTexture: [SKTexture] = []
    
    for i in 0...44 {
        let textureName = String(format: "cat_%05d", i)
        let texture = SKTexture(imageNamed: textureName)
        catTexture.append(texture)
    }
    
    let catAnimation = SKAction.animate(with: catTexture, timePerFrame: 0.03, resize: false, restore: true)
    let repeatCat = SKAction.repeatForever(catAnimation)
    catNode?.run(repeatCat, withKey: "cat")
}

func touchBuilding(nodeName: String, gameCenter: GameCenterManager) {
    switch nodeName {
        case "battleBuilding":
            gameCenter.startMatchmaking()
        case "blacksmith_00000", "blacksmith_00001", "blacksmith_00002", "blacksmith_00003", "blacksmith_00004", "blacksmith_00005", "blacksmith_00006", "blacksmith_00007", "blacksmith_00008", "blacksmith_00009", "blacksmith_00010", "blacksmith_00011", "blacksmith_00012", "blacksmith_00013", "blacksmith_00014", "blacksmith_00015", "blacksmith_00016", "blacksmith_00017", "blacksmith_00018", "blacksmith_00019", "blacksmith_00020", "blacksmith_00021", "blacksmith_00022", "blacksmith_00023", "blacksmith_00024", "blacksmith_00025", "blacksmith_00026", "blacksmith_00027", "blacksmith_00028", "blacksmith_00029":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "blacksmith"
        case "dinerBuilding":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "dinerBuilding"
        case "questBuilding":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "questBuilding"
        case "horse_00000", "horse_0001", "horse_0002", "horse_0003", "horse_0004", "horse_0005", "horse_0006", "horse_0007", "horse_0008", "horse_0009", "horse_0010", "horse_0011", "horse_0012", "horse_0013", "horse_0014", "horse_0015", "horse_0016", "horse_0017", "horse_0018", "horse_0019", "horse_0020", "horse_0021", "horse_0022", "horse_0023", "horse_0024", "horse_0025", "horse_0026", "horse_0027", "horse_0028", "horse_0029":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "horse"
        case "npcFish":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "npcFish"
        case "npcFlower":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "npcFlower"
        case "apple":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "apple"
        case "cat":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "cat"
        case "npcHouse":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "npcHouse"
        case "sparks":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "sparks"
        case "chest_opened":
            VariableManager.shared.interactionButtonHidden = false
            VariableManager.shared.touchBuilding = "chest_opened"
        default:
            break
    }
}
