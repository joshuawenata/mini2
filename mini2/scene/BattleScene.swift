import SpriteKit
import SwiftUI

class BattleScene: SKScene, SKPhysicsContactDelegate {
    var characterNode: SKSpriteNode?
    var dummyRobot: SKSpriteNode?
    var first = true
    var swordNode: SKSpriteNode?
    var meleeAreaNode: SKSpriteNode?
    var slashNode: SKSpriteNode?
    var projectileNode: SKSpriteNode?
    let moveJoystick = TLAnalogJoystick(withDiameter: 200)
    let rotateJoystick = TLAnalogJoystick(withDiameter: 200)
    let skillJoystick = TLAnalogJoystick(withDiameter: 120)
    var xOffset = 0.0
    var yOffset = 0.0
    var counterDidBegin = 0
    var hpEnemy = 100
    var isHitMelee = false
    var isHitProjectile = false
    
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    
    let cameraNode = SKCameraNode()
    
    var joystickStickImageEnabled = true {
        didSet {
            let jImage = UIImage(named: "jStick")
            let rImage = UIImage(named: "rStick")
            moveJoystick.handleImage = jImage
            rotateJoystick.handleImage = rImage
            skillJoystick.handleImage = UIImage(named: "fireballIcon")
            setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Remove" : "Set") stick image"
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let jImage = UIImage(named: "jSubstrate")
            let rImage = UIImage(named: "rSubstrate")
            moveJoystick.baseImage = jImage
            rotateJoystick.baseImage = rImage
            skillJoystick.baseImage = jImage
            setJoystickSubstrateImageBtn.text = "\(joystickSubstrateImageEnabled ? "Remove" : "Set") substrate image"
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        counterDidBegin += 1
        let a = contact.bodyA.contactTestBitMask
        let b = contact.bodyB.contactTestBitMask
//        print("a = \(a)")
//        print("b = \(b)")
        if a == 3 && b == 2 {
            print("Is Hit!!!")
            print("current HP: \(hpEnemy)")
            isHitMelee = true
        } else if a == 3 && b == 1 {
            print("Is FIRE!!!")
            print("current HP: \(hpEnemy)")
            projectileNode?.removeFromParent()
            isHitProjectile = true
        } else {
            print("Is NOT Hit!!!")
            isHitMelee = false
            isHitProjectile = false
        }
    }
    
//    func didEnd(_ contact: SKPhysicsContact) {
//        print("Not Fired!!")
//        isHitMelee = false
//        isHitProjectile = false
//    }
//    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = .clear
        let background = SKSpriteNode(imageNamed: "battleIsland")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        addCharacterBattle(CGPoint(x: frame.midX, y: frame.midY),category: 0,contact: 0,collision: 0)
        
        addDummyRobot(CGPoint(x: frame.midX+200, y: frame.midY), category: 2, contact: 3)
        
        swordNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "defaultSword")
        meleeAreaNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "meleeArea",isPhysicsBody: true, category: 2, contact: 2, collision: 1)
        slashNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "slash_00000")
        meleeAreaNode?.isHidden = true
        meleeAreaNode?.zPosition = 2
        slashNode?.isHidden = true
        
        swordNode?.zRotation = -20
        swordNode?.position.x = -40
        
        slashNode?.setScale(0.5)
        slashNode?.position.x = 0
        
        
        configureJoysticks()
        physicsWorld.contactDelegate = self
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
        
        moveJoystick.on(.begin) { [unowned self] _ in
            startWalkingAnimationBattle(characterNode: characterNode)
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            
            let pVelocity = joystick.velocity
            let speed = CGFloat(0.12)
            
            let dx = pVelocity.x * speed
            let dy = pVelocity.y * speed
            
            characterNode.position.x += dx
            characterNode.position.y += dy
            
            swordNode?.position.x += dx
            swordNode?.position.y += dy
            
            meleeAreaNode?.position.x += dx
            meleeAreaNode?.position.y += dy
            
            slashNode?.position.x += dx
            slashNode?.position.y += dy
            
            self.cameraNode.position = characterNode.position
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            stopWalkingAnimationBattle(characterNode: characterNode)
        }
        
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
        
        skillJoystick.on(.end) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            
            // Create projectile sprite node
            guard let projectileImage = UIImage(named: "fireballThrow") else {
                return
            }
            
            // Ensure physics body is created and set properties
            let texture = SKTexture(image: projectileImage)
            let projectile = SKSpriteNode(texture: texture)
            projectile.setScale(0.3)

            
            projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width / 2)
            projectile.physicsBody?.affectedByGravity = false
            projectile.physicsBody?.linearDamping = 0 // Remove for testing

            // Calculate position based on angle and quadrant
            let position = calculateProjectilePosition(degree: joystick.velocity, from: characterNode.position, projectile: projectile)
            projectile.position = position
            projectile.zPosition = -1
            
            projectile.physicsBody?.categoryBitMask = 1
            projectile.physicsBody?.contactTestBitMask = 1
            
            let velocityOfMoving:CGFloat = 150
            var nextPosition: CGPoint = projectile.position
            
            if GLKMathRadiansToDegrees(Float(joystick.angular)) > -30 && GLKMathRadiansToDegrees(Float(joystick.angular)) < 30 {
                nextPosition.y += velocityOfMoving
                nextPosition.x = projectile.position.x
                projectile.zRotation = 0
            } else if GLKMathRadiansToDegrees(Float(joystick.angular)) < -150 || GLKMathRadiansToDegrees(Float(joystick.angular)) > 150 {
                nextPosition.y -= velocityOfMoving
                nextPosition.x = projectile.position.x
                projectile.zRotation = 3.1
            } else if GLKMathRadiansToDegrees(Float(joystick.angular)) > 60 && GLKMathRadiansToDegrees(Float(joystick.angular)) < 120 {
                nextPosition.y = projectile.position.y
                nextPosition.x -= velocityOfMoving
                projectile.zRotation = -11
            } else if GLKMathRadiansToDegrees(Float(joystick.angular)) < -60 && GLKMathRadiansToDegrees(Float(joystick.angular)) > -120 {
                nextPosition.y = projectile.position.y
                nextPosition.x += velocityOfMoving
                projectile.zRotation = 11
            } else if GLKMathRadiansToDegrees(Float(joystick.angular)) > 30 && GLKMathRadiansToDegrees(Float(joystick.angular)) < 60 {
                nextPosition.y += velocityOfMoving
                nextPosition.x -= velocityOfMoving
                projectile.zRotation = 7
            } else if GLKMathRadiansToDegrees(Float(joystick.angular)) > 90 && GLKMathRadiansToDegrees(Float(joystick.angular)) < 150 {
                nextPosition.y -= velocityOfMoving
                nextPosition.x -= velocityOfMoving
                projectile.zRotation = 15
            } else if GLKMathRadiansToDegrees(Float(joystick.angular)) < -30 && GLKMathRadiansToDegrees(Float(joystick.angular)) > -60 {
                nextPosition.y += velocityOfMoving
                nextPosition.x += velocityOfMoving
                projectile.zRotation = -7
            } else if GLKMathRadiansToDegrees(Float(joystick.angular)) > -150 && GLKMathRadiansToDegrees(Float(joystick.angular)) < -120 {
                nextPosition.y -= velocityOfMoving
                nextPosition.x += velocityOfMoving
                projectile.zRotation = -15
            } else {
                print("Unknown!!")
            }
            
            let path = createPath(from: projectile.position, to: nextPosition)
         
            let moveAction = SKAction.follow(path, asOffset: false, orientToPath: false, speed: 300)
            let wait = SKAction.wait(forDuration: 0.6)
            let updatePosition = SKAction.run {
                projectile.removeFromParent()
            }
            let sequence = SKAction.sequence([wait, updatePosition])
            projectile.run(moveAction)
            addChild(projectile)
            projectileNode = projectile
            run(sequence)
            if isHitProjectile {
                print("Mengurangi Health!")
                hpEnemy -= 10
                isHitProjectile = false
            }
        }
        
        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true
        
        view?.isMultipleTouchEnabled = true
    }
    
    func addCharacterBattle(_ position: CGPoint, category: UInt32, contact: UInt32, collision: UInt32) {
        guard let characterImage = UIImage(named: "charaIdleBattle") else {
            return
        }
        
        let texture = SKTexture(image: characterImage)
        let character = SKSpriteNode(texture: texture)
        character.physicsBody = SKPhysicsBody(texture: texture, size: character.size)
        character.physicsBody?.affectedByGravity = false
        character.position = CGPoint(x: 0, y: 0)
        character.setScale(0.3)
        character.physicsBody?.categoryBitMask = category
        character.physicsBody?.contactTestBitMask = contact
        character.physicsBody?.collisionBitMask = collision
        addChild(character)
        characterNode = character
        
        startIdleAnimationBattle(characterNode: characterNode)
    }
    
    func addDummyRobot(_ position: CGPoint, category: UInt32, contact: UInt32) {
        guard let characterImage = UIImage(named: "charaIdleBattle") else {
            return
        }
        
        let texture = SKTexture(image: characterImage)
        let character = SKSpriteNode(texture: texture)
        character.physicsBody = SKPhysicsBody(texture: texture, size: character.size)
        character.physicsBody?.affectedByGravity = false
        character.physicsBody?.allowsRotation = false
        character.position = CGPoint(x: 200, y: 0)
        character.setScale(0.3)
        character.physicsBody?.categoryBitMask = category
        character.physicsBody?.contactTestBitMask = contact
        character.physicsBody?.isDynamic = false
        
        addChild(character)
        
        dummyRobot = character
        
    }
    
    func addItem(_ position: CGPoint, imageName: String, isPhysicsBody: Bool = false, category: UInt32 = 0, contact: UInt32 = 0, collision: UInt32 = 0) -> SKSpriteNode {
        guard let itemImage = UIImage(named: imageName) else {
            return SKSpriteNode()
        }
        
        let texture = SKTexture(image: itemImage)
        let item = SKSpriteNode(texture: texture)
        if(isPhysicsBody){
            item.physicsBody = SKPhysicsBody(texture: texture, size: item.size)
            item.physicsBody?.affectedByGravity = false
            item.physicsBody?.categoryBitMask = category
            item.physicsBody?.contactTestBitMask = contact
            item.physicsBody?.collisionBitMask = collision
        }
        item.position = CGPoint(x: -60, y: 0)
        item.setScale(0.3)
        addChild(item)
        
        return item
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        return
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if moveJoystick.contains(location) {
                moveJoystick.touchesMoved(touches, with: event)
            } else if rotateJoystick.contains(location) {
                rotateJoystick.touchesMoved(touches, with: event)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if moveJoystick.contains(location) {
                moveJoystick.touchesEnded(touches, with: event)
            } else if rotateJoystick.contains(location) {
                rotateJoystick.touchesEnded(touches, with: event)
            }
        }
    }
    
    func createPath(from start: CGPoint, to destination: CGPoint) -> CGMutablePath {
        let pathToMove = CGMutablePath()
        pathToMove.move(to: start)
        pathToMove.addLine(to: destination)
        return pathToMove
    }
    
    // Function to calculate projectile position considering quadrant and coordinate system
    func calculateProjectilePosition(degree: CGPoint, from applePosition: CGPoint, projectile: SKSpriteNode) -> CGPoint {

        // Adjust signs based on quadrant
        let x = Float(applePosition.x) + Float(degree.x)
        let y = Float(applePosition.y) + Float(degree.y) // Inverted for SpriteKit coordinate system

        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if hpEnemy <= 0 {
            dummyRobot?.removeFromParent()
        }
    }
}
