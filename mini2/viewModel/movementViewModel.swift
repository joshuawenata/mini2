//
//  movementViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 12/06/24.
//

import Foundation
import SpriteKit

func startIdleAnimation(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    let idleTextures = [SKTexture(imageNamed: "charaIdle")]
    let idleAnimation = SKAction.animate(with: idleTextures, timePerFrame: 0.2, resize: false, restore: true)
    let repeatIdle = SKAction.repeatForever(idleAnimation)
    characterNode.run(repeatIdle, withKey: "idle")
}

func startWalkingAnimation(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    let walkTextures = [SKTexture(imageNamed: "charaWalk"), SKTexture(imageNamed: "charaIdle")]
    let walkAnimation = SKAction.animate(with: walkTextures, timePerFrame: 0.2, resize: false, restore: true)
    let repeatWalk = SKAction.repeatForever(walkAnimation)
    characterNode.run(repeatWalk, withKey: "walk")
    
    characterNode.removeAction(forKey: "idle")
}

func stopWalkingAnimation(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    characterNode.removeAction(forKey: "walk")
    startIdleAnimation(characterNode: characterNode)
}

func startIdleAnimationBattle(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    let idleTextures = [SKTexture(imageNamed: "charaIdleBattle")]
    let idleAnimation = SKAction.animate(with: idleTextures, timePerFrame: 0.2, resize: false, restore: true)
    let repeatIdle = SKAction.repeatForever(idleAnimation)
    characterNode.run(repeatIdle, withKey: "idle")
}

func startWalkingAnimationBattle(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    let walkTextures = [SKTexture(imageNamed: "charaWalkBattle"), SKTexture(imageNamed: "charaIdleBattle")]
    let walkAnimation = SKAction.animate(with: walkTextures, timePerFrame: 0.2, resize: false, restore: true)
    let repeatWalk = SKAction.repeatForever(walkAnimation)
    characterNode.run(repeatWalk, withKey: "walk")
    
    characterNode.removeAction(forKey: "idle")
}

func stopWalkingAnimationBattle(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    characterNode.removeAction(forKey: "walk")
    startIdleAnimationBattle(characterNode: characterNode)
}
