//
//  joystickViewModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 25/06/24.
//

import Foundation
import SpriteKit

extension BattleScene {
    
    func moveJoystickConfig() {
        moveJoystick.on(.begin) { [unowned self] _ in
            startWalkingAnimationBattle(characterNode: characterNode)
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            
            guard let hpBarInner = self.hpBarInner else {
                return
            }
            
            guard let hpBarOuter = self.hpBarOuter else {
                return
            }
            
            guard let playerName = self.playerName else {
                return
            }
            
            let pVelocity = joystick.velocity
            let speed = CGFloat(0.12)
            
            let dx = pVelocity.x * speed
            let dy = pVelocity.y * speed
            
            moveNode(node: characterNode, label: nil, dx: dx, dy: dy)
            
            moveNode(node: swordNode, label: nil, dx: dx, dy: dy)
            
            moveNode(node: meleeAreaNode, label: nil, dx: dx, dy: dy)
            
            moveNode(node: rangeAreaNode, label: nil, dx: dx, dy: dy)
            
            moveNode(node: slashNode, label: nil, dx: dx, dy: dy)
           
            moveNode(node: hpBarOuter, label: nil, dx: dx, dy: dy)
            
            moveNode(node: hpBarInner, label: nil, dx: dx, dy: dy)
            
            moveNode(node: nil, label: playerName, dx: dx, dy: dy)
                        
            self.cameraNode.position = characterNode.position
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            stopWalkingAnimationBattle(characterNode: characterNode)
        }
    }
    
    func moveNode(node: SKSpriteNode?, label: SKLabelNode?, dx: CGFloat, dy: CGFloat) {
        if label != nil || node == nil {
            label?.position.y += dy
            label?.position.x += dx
        } else {
            node?.position.x += dx
            node?.position.y += dy
        }
    }
    
    func rotateJoystickConfig() {
        rotateJoystick.on(.begin) { [unowned self] _ in
            guard let meleeAreaNode = self.meleeAreaNode else {
                return
            }
            guard let slashNode = self.slashNode else {
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
            guard let meleeAreaNode = self.meleeAreaNode else {
                return
            }
            guard let slashNode = self.slashNode else {
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
            guard let swordNode = self.swordNode else {
                return
            }
            guard let meleeAreaNode = self.meleeAreaNode else {
                return
            }
            guard let slashNode = self.slashNode else {
                return
            }
            slashNode.position.x -= xOffset
            slashNode.position.y -= yOffset
            slashNode.isHidden = false
            startSlashAnimation(slashNode: slashNode)
            meleeAreaNode.isHidden = true
            meleeAreaNode.position.x -= 60
            self.meleeAreaNode?.zRotation = 0
            
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
            }
        }
    }
    
    func skillJoystickConfig() {
        skillJoystick.on(.begin) { [unowned self] _ in
            guard let rangeAreaNode = self.rangeAreaNode else {
                return
            }
            
            rangeAreaNode.isHidden = false
            rangeAreaNode.position.x += 60
            rangeAreaNode.setScale(0.5)
            rangeAreaNode.anchorPoint = CGPoint(x: 1.0, y: 0.5)
            self.isOtherHit = true
        }
        
        skillJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            guard let rangeAreaNode = self.rangeAreaNode else {
                return
            }
            
            let margin: CGFloat = 70.0
            self.xOffset = cos(joystick.angular - 1.57) * margin
            self.yOffset = sin(joystick.angular - 1.57) * margin
            rangeAreaNode.position.x = characterNode.position.x - xOffset
            rangeAreaNode.position.y = characterNode.position.y - yOffset
            rangeAreaNode.zRotation = joystick.angular-1.57
            self.isOtherHit = false
        }
        
        skillJoystick.on(.end) { [unowned self] joystick in
            guard let characterNode = self.characterNode else { return }
            guard let rangeAreaNode = self.rangeAreaNode else { return }
            
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

            self.isOtherHit = false
            
            addChild(projectile)
            projectileNode = projectile
            
            if !self.isOtherHit {
                anotherProjectileNode.removeFromParent()
            }
            
            if isHitProjectile {
                print("Mengurangi Health!")
                hpEnemy -= 10
                isHitProjectile = false
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
        let sequence = SKAction.sequence([moveAction, updatePosition])
        
        projectile.run(sequence)
        
        return projectile
    }
}
