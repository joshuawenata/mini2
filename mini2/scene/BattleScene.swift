import SpriteKit
import SwiftUI

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let character: UInt32 = 0x1 << 0
    static let meleeArea: UInt32 = 0x1 << 1
    static let rangeArea: UInt32 = 0x1 << 2
    static let projectile: UInt32 = 0x1 << 3
    static let enemy: UInt32 = 0x1 << 4
}

class BattleScene: SKScene, SKPhysicsContactDelegate {
    var characterNode: SKSpriteNode!
    var hpBarInner: SKSpriteNode?
    var hpBarOuter: SKSpriteNode?
    var dummyRobot: SKSpriteNode?
    var first = true
    var swordNode: SKSpriteNode?
    var meleeAreaNode: SKSpriteNode?
    var rangeAreaNode: SKSpriteNode?
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
    
    let gameCenter = GameCenterManager.shared
    var gameModel: GameModel!
    var anotherPlayer: SKSpriteNode!
    
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
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        // Check for melee hit
        if (bodyA.categoryBitMask == PhysicsCategory.meleeArea && bodyB.categoryBitMask == PhysicsCategory.enemy) ||
           (bodyA.categoryBitMask == PhysicsCategory.enemy && bodyB.categoryBitMask == PhysicsCategory.meleeArea) {
            print("Is Hit!!!")
            print("current HP: \(hpEnemy)")
            isHitMelee = true
        }
        
        // Check for projectile hit
        if (bodyA.categoryBitMask == PhysicsCategory.projectile && bodyB.categoryBitMask == PhysicsCategory.enemy) ||
           (bodyA.categoryBitMask == PhysicsCategory.enemy && bodyB.categoryBitMask == PhysicsCategory.projectile) {
            print("Is FIRE!!!")
            print("current HP: \(hpEnemy)")
            projectileNode?.removeFromParent()
            isHitProjectile = true
        }
        
        // If neither, not a hit
        if !(isHitMelee || isHitProjectile) {
            print("Is NOT Hit!!!")
            isHitMelee = false
            isHitProjectile = false
        }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = .clear
        let background = SKSpriteNode(imageNamed: "battleIsland")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        addCharacterBattle(CGPoint(x: frame.midX, y: frame.midY),category: PhysicsCategory.character, contact: PhysicsCategory.none, collision: PhysicsCategory.none)
        
        addDummyRobot(CGPoint(x: frame.midX+200, y: frame.midY), category: PhysicsCategory.enemy, contact: PhysicsCategory.meleeArea | PhysicsCategory.projectile)

        swordNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "defaultSword")
        meleeAreaNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "meleeArea",isPhysicsBody: true, category: PhysicsCategory.meleeArea, contact: PhysicsCategory.enemy, collision: PhysicsCategory.none)
        rangeAreaNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "rangeArea",isPhysicsBody: false, category: PhysicsCategory.rangeArea, contact: PhysicsCategory.enemy, collision: PhysicsCategory.none)
        slashNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "slash_00000")
        meleeAreaNode?.isHidden = true
        meleeAreaNode?.zPosition = -1
        rangeAreaNode?.isHidden = true
        rangeAreaNode?.zPosition = -1
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
            
            guard let hpBarInner = self.hpBarInner else {
                return
            }
            
            guard let hpBarOuter = self.hpBarOuter else {
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
            
            rangeAreaNode?.position.x += dx
            rangeAreaNode?.position.y += dy
            
            slashNode?.position.x += dx
            slashNode?.position.y += dy
            
            hpBarOuter.position.x += dx
            hpBarOuter.position.y += dy
            
            hpBarInner.position.x += dx
            hpBarInner.position.y += dy
            
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
        
        skillJoystick.on(.begin) { [unowned self] _ in
            guard let rangeAreaNode = self.rangeAreaNode else {
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
            guard let rangeAreaNode = self.rangeAreaNode else {
                return
            }
            
            let margin: CGFloat = 70.0
            self.xOffset = cos(joystick.angular - 1.57) * margin
            self.yOffset = sin(joystick.angular - 1.57) * margin
            rangeAreaNode.position.x = characterNode.position.x - xOffset
            rangeAreaNode.position.y = characterNode.position.y - yOffset
            rangeAreaNode.zRotation = joystick.angular-1.57
        }
        
        skillJoystick.on(.end) { [unowned self] joystick in
            guard let characterNode = self.characterNode else { return }
            guard let rangeAreaNode = self.rangeAreaNode else { return }
            
            rangeAreaNode.isHidden = true
            rangeAreaNode.position.x -= 60
            
            guard let projectileImage = UIImage(named: "fire_1") else { return }
            
            let texture = SKTexture(image: projectileImage)
            let projectile = SKSpriteNode(texture: texture)
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
            
            let velocityOfMoving: CGFloat = 200
            let angle = CGFloat(joystick.angular)
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
            addChild(projectile)
            projectileNode = projectile
            
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
        
        guard let hpBarOuterImage = UIImage(named: "hpbarouter") else {
            return
        }
        guard let hpBarInnerTexture = UIImage(named: "hpbarinner") else {
            return
        }

        let hpbartextureinner = SKTexture(image: hpBarInnerTexture)
        let hpbarinner = SKSpriteNode(texture: hpbartextureinner)
        hpbarinner.position = CGPoint(x: 0, y: 54)
        
        let hpbartextureouter = SKTexture(image: hpBarOuterImage)
        let hpbarouter = SKSpriteNode(texture: hpbartextureouter)
        hpbarouter.position = CGPoint(x: -5, y: 50)
        
        addChild(hpbarinner)
        addChild(hpbarouter)
        
        hpBarInner = hpbarinner
        hpBarOuter = hpbarouter
        
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
    
    override func update(_ currentTime: TimeInterval) {
        if hpEnemy <= 0 {
            dummyRobot?.removeFromParent()
        }
        
        gameModel = GameModel(player: characterNode.position, name: gameCenter.player2Name)
        gameCenter.sendGameModel(gameModel)
        
        if gameCenter.dataModel != nil {
            print("game center model", gameCenter.dataModel!)
            if anotherPlayer != nil {
                print("another player")
                anotherPlayer.position = gameCenter.dataModel!.player
            } else {
                anotherPlayer = addCharacterPlayer(gameCenter.dataModel!.player)
                addChild(anotherPlayer)
            }
        }
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
    
    func calculateProjectilePosition(degree: CGPoint, from applePosition: CGPoint, projectile: SKSpriteNode) -> CGPoint {

        let x = Float(applePosition.x) + Float(degree.x)
        let y = Float(applePosition.y) + Float(degree.y)

        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
}
