//
//  joystickViewModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 25/06/24.
//

import Foundation
import SpriteKit
import SwiftUI

extension BattleScene {
    
    func moveJoystickConfig() {
        let footstepSound = SKAudioNode(fileNamed: "footsteps.mp3")
        
        moveJoystick.on(.begin) { [unowned self] _ in
            startWalkingAnimationBattle(characterNode: characterNode)
            addChild(footstepSound)
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            self.isOtherHit = false
            guard let characterNode = self.characterNode else {
                return
            }
            
            guard let hpBarInner = self.hpBarInner else {
                return
            }
            
            guard let hpBarOuter = self.hpBarOuter else {
                return
            }
            
            guard let playerName = self.currentPlayerName else {
                return
            }
            
            let pVelocity = joystick.velocity
            let speed = CGFloat(0.12)
            
            let dx = pVelocity.x * speed
            let dy = pVelocity.y * speed
            
            moveNode(node: characterNode, dx: dx, dy: dy)
            moveNode(node: currentSwordNode, dx: dx, dy: dy)
            moveNode(node: currentMeleeAreaNode, dx: dx, dy: dy)
            moveNode(node: currentRangeAreaNode, dx: dx, dy: dy)
            moveNode(node: currentSlashNode, dx: dx, dy: dy)
            moveNode(node: hpBarOuter, dx: dx, dy: dy)
            moveNode(node: hpBarInner, dx: dx, dy: dy)
            moveNode(label: playerName, dx: dx, dy: dy)
            
            self.cameraNode.position = characterNode.position
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            stopWalkingAnimationBattle(characterNode: characterNode)
            footstepSound.removeFromParent()
        }
    }
    
    func rotateJoystickConfig() {
        //        let swordSound = SKAudioNode(fileNamed: "swoosh1.mp3")
        
        rotateJoystick.on(.begin) { [unowned self] _ in
            guard let meleeAreaNode = self.currentMeleeAreaNode else {
                return
            }
            guard let slashNode = self.currentSlashNode else {
                return
            }
            meleeAreaNode.isHidden = false
            meleeAreaNode.position.x += 60
            meleeAreaNode.setScale(0.5)
            meleeAreaNode.anchorPoint = CGPoint(x: 1.0, y: 0)
            
            slashNode.position.x = meleeAreaNode.position.x
            slashNode.position.y = meleeAreaNode.position.y
        }
        
        rotateJoystick.on(.move) { [unowned self] joystick in
            guard let meleeAreaNode = self.currentMeleeAreaNode else {
                return
            }
            guard let slashNode = self.currentSlashNode else {
                return
            }
            
            let margin: CGFloat = 50.0
            self.xOffset = cos(joystick.angular - 0.5) * margin
            self.yOffset = sin(joystick.angular - 0.5) * margin
            
            meleeAreaNode.zRotation = joystick.angular
            slashNode.zRotation = joystick.angular
        }
        
        rotateJoystick.on(.end) { [unowned self] _ in
            startAttackAnimationBattle(characterNode: characterNode)
            guard let swordNode = self.currentSwordNode else {
                return
            }
            guard let meleeAreaNode = self.currentMeleeAreaNode else {
                return
            }
            guard let slashNode = self.currentSlashNode else {
                return
            }
            slashNode.position.x -= xOffset
            slashNode.position.y -= yOffset
            slashNode.isHidden = false
            startSlashAnimation(slashNode: slashNode)
            meleeAreaNode.isHidden = true
            meleeAreaNode.position.x -= 60
            self.currentMeleeAreaNode?.zRotation = 0
            
            if(first){
                swordNode.position.y -= 25
                first = false
            }
            
            swordNode.anchorPoint = CGPoint(x: 1.0, y: 0)
            let rotateRight = SKAction.rotate(byAngle: 60 * (.pi / 180), duration: 0.2)
            let rotateLeft = SKAction.rotate(byAngle: -60 * (.pi / 180), duration: 0.2)
            let rotateSequence = SKAction.sequence([rotateRight, rotateLeft])
            let repeatRotation = SKAction.repeat(rotateSequence, count: 1)
            
            swordNode.run(repeatRotation)
            if isHitMelee {
                hpEnemy -= 10
                startGetHitAnimation(characterNode: self.dummyRobot)
            }
            
            if let url = Bundle.main.url(forResource: "swoosh2", withExtension: "wav") {
                audioManager.loadAudioFiles(urls: [url])
                audioManager.play()
            }
        }
    }
    
    func skillJoystickConfig() {
        var skillCooldownActive = false
        
        skillJoystick.on(.begin) { [unowned self] _ in
            guard let rangeAreaNode = self.currentRangeAreaNode else {
                return
            }
            if skillCooldownActive {
                return
            }
            rangeAreaNode.isHidden = false
            rangeAreaNode.position.x += 60
            rangeAreaNode.setScale(0.5)
            rangeAreaNode.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        skillJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            guard let rangeAreaNode = self.currentRangeAreaNode else {
                return
            }
            
            if skillCooldownActive {
                return
            }
            
            let margin: CGFloat = 70.0
            self.xOffset = cos(joystick.angular - 1.57) * margin
            self.yOffset = sin(joystick.angular - 1.57) * margin
            rangeAreaNode.position.x = characterNode.position.x - xOffset
            rangeAreaNode.position.y = characterNode.position.y - yOffset
            rangeAreaNode.zRotation = joystick.angular - 1.57
        }
        
        skillJoystick.on(.end) { [unowned self] joystick in
            guard let characterNode = self.characterNode else { return }
            guard let rangeAreaNode = self.currentRangeAreaNode else { return }
            if skillCooldownActive {
                return
            }
            
            self.isOtherHit = true
            
            rangeAreaNode.isHidden = true
            rangeAreaNode.position.x -= 60
            
            guard let projectileImage = UIImage(named: "fire_1") else { return }
            
            let texture = SKTexture(image: projectileImage)
            var projectile = SKSpriteNode(texture: texture)
            projectile.setScale(0.2)
            
            projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width / 2)
            projectile.physicsBody?.affectedByGravity = false
            projectile.physicsBody?.linearDamping = 0
            
            startSkillAnimation(projectileNode: projectile, imageSet: ["fire_1", "fire_2", "fire_3", "fire_4", "fire_5"], timePerFrame: 0.1)
            
            projectile.position = characterNode.position
            projectile.zPosition = -1
            
            projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
            projectile.physicsBody?.contactTestBitMask = PhysicsCategory.enemy
            projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
            
            self.angle = CGFloat(joystick.angular)
            
            projectile = projectileMove(angle: self.angle, projectile: projectile)
            
            addChild(projectile)
            projectileNode = projectile
            
            if isHitProjectile {
                print("Mengurangi Health!")
                hpEnemy -= 10
                isHitProjectile = false
                startGetHitAnimation(characterNode: self.dummyRobot)
            }
            
            if let url = Bundle.main.url(forResource: "fireball", withExtension: "wav") {
                audioManager.loadAudioFiles(urls: [url])
                audioManager.play()
            }
            
            skillCooldownActive = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                skillCooldownActive = false
            }
        }
    }
    
    func configureJoysticks() {
        addChild(cameraNode)
        camera = cameraNode
        
        cameraNode.addChild(moveJoystick)
        moveJoystick.position = CGPoint(x: -300, y: -100)
        
        cameraNode.addChild(rotateJoystick)
        rotateJoystick.position = CGPoint(x: 300, y: -100)
        
        cameraNode.addChild(skillJoystick)
        skillJoystick.position = CGPoint(x: 200, y: -25)
        
        moveJoystickConfig()
        rotateJoystickConfig()
        skillJoystickConfig()
        
        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true
        
        view?.isMultipleTouchEnabled = true
    }
    
    func projectileMove(angle: CGFloat, projectile: SKSpriteNode) -> SKSpriteNode {
        let velocityOfMoving: CGFloat = 200
        let dy = cos(angle) * velocityOfMoving
        let dx = sin(angle) * velocityOfMoving
        
        projectile.zRotation = angle + CGFloat.pi
        
        let nextPosition = CGPoint(x: projectile.position.x - dx, y: projectile.position.y + dy)
        let path = createPath(from: projectile.position, to: nextPosition)
        
        let moveAction = SKAction.follow(path, asOffset: false, orientToPath: false, speed: 300)
        let updatePosition = SKAction.run {
            projectile.removeFromParent()
        }
        let removeAction = SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.removeFromParent()
        ])
        let sequence = SKAction.sequence([moveAction, updatePosition, removeAction])
        
        projectile.run(sequence)
        
        return projectile
    }
    
}

