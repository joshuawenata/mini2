import SpriteKit
import SwiftUI
import SwiftData

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let character: UInt32 = 0x1 << 0
    static let meleeArea: UInt32 = 0x1 << 1
    static let rangeArea: UInt32 = 0x1 << 2
    static let projectile: UInt32 = 0x1 << 3
    static let enemy: UInt32 = 0x1 << 4
    static let otherPlayer: UInt32 = 0x1 << 5
}

class BattleScene: SKScene, SKPhysicsContactDelegate {
    var characterNode: SKSpriteNode!
    var hpBarInner: SKSpriteNode!
    var hpBarOuter: SKSpriteNode!
    var dummyRobot: SKSpriteNode?
    var first = true
    var swordNode: SKSpriteNode!
    var meleeAreaNode: SKSpriteNode!
    var rangeAreaNode: SKSpriteNode!
    var slashNode: SKSpriteNode!
    var projectileNode: SKSpriteNode!
    var anotherProjectileNode: SKSpriteNode!
    let moveJoystick = TLAnalogJoystick(withDiameter: 200)
    let rotateJoystick = TLAnalogJoystick(withDiameter: 200)
    let skillJoystick = TLAnalogJoystick(withDiameter: 120)
    var xOffset = 0.0
    var yOffset = 0.0
    var counterDidBegin = 0
    var hpEnemy = 100
    var isHitMelee = false
    var isHitProjectile = false
    var ghostAdded = false
    var playerName: SKLabelNode!
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    var isOtherHit = false
    
    let cameraNode = SKCameraNode()
    
    let gameCenter = GameCenterManager.shared
    var gameModel: GameModel!
    var angle = CGFloat()
    
    // COMPONENT FOR OTHER PLAYER
    var anotherPlayer: SKSpriteNode!
    var anotherPlayerNameLabel: SKLabelNode!
    var anotherPlayerHpBarInner: SKSpriteNode!
    var anotherPlayerHpBarOuter: SKSpriteNode!
    var anotherPlayerSword: SKSpriteNode!
    var anotherPlayerMeleeArea: SKSpriteNode!
    var anotherPlayerSlash: SKSpriteNode!
    var anotherPlayerProjectileNode: SKSpriteNode!
    var anotherPlayerSwordNode: SKSpriteNode!
    var anotherPlayerRange: SKSpriteNode!
    
//    @Environment(\.modelContext) private var modelWatch
//    @Query private var character: [Character]
    var character: Character
    
    init(size: CGSize, character: Character) {
       self.character = character
       super.init(size: size)
     }

     // ... rest of your BattleScene code
     required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) is not supported")
     }
    
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
        
        // Check for melee hit
        if (bodyA.categoryBitMask == PhysicsCategory.meleeArea && bodyB.categoryBitMask == PhysicsCategory.otherPlayer) ||
           (bodyA.categoryBitMask == PhysicsCategory.otherPlayer && bodyB.categoryBitMask == PhysicsCategory.meleeArea) {
            print("Is Hit!!!")
            print("current HP: \(hpEnemy)")
        }
        
        // Check for projectile hit
        if (bodyA.categoryBitMask == PhysicsCategory.projectile && bodyB.categoryBitMask == PhysicsCategory.otherPlayer) ||
           (bodyA.categoryBitMask == PhysicsCategory.otherPlayer && bodyB.categoryBitMask == PhysicsCategory.projectile) {
            print("Is FIRE!!!")
            print("current HP: \(hpEnemy)")
            projectileNode?.removeFromParent()
            anotherProjectileNode?.removeFromParent()
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
        
        let _ = addBackground()
        
        addCharacterBattle(CGPoint(x: frame.midX, y: frame.midY),category: PhysicsCategory.character, contact: PhysicsCategory.none, collision: PhysicsCategory.none, name: gameCenter.localPlayer.displayName, version: "self")
        
        addDummyRobot(CGPoint(x: 200, y: 0), category: PhysicsCategory.enemy, contact: PhysicsCategory.meleeArea | PhysicsCategory.projectile)

        swordNode = addItem(CGPoint(x: -60, y: 0), imageName: "defaultSword")
        
        meleeAreaNode = addItem(CGPoint(x: -60, y: 0), imageName: "meleeArea",isPhysicsBody: true, category: PhysicsCategory.meleeArea, contact: PhysicsCategory.enemy, collision: PhysicsCategory.none)
        
        rangeAreaNode = addItem(CGPoint(x: -60, y: 0), imageName: "rangeArea",isPhysicsBody: false, category: PhysicsCategory.rangeArea, contact: PhysicsCategory.enemy, collision: PhysicsCategory.none)
        
        slashNode = addItem(CGPoint(x: -60, y: 0), imageName: "slash_00000")
        
        configureAttackProperties(mele: meleeAreaNode, range: rangeAreaNode, slash: slashNode, sword: swordNode)
        
        configureJoysticks()
        
        physicsWorld.contactDelegate = self
    }
    
    func configureAttackProperties(mele: SKSpriteNode?, range: SKSpriteNode?, slash: SKSpriteNode?, sword: SKSpriteNode?) {
        mele?.isHidden = true
        mele?.zPosition = -1
        
        range?.isHidden = true
        range?.zPosition = -1
        
        slash?.isHidden = true
        
        sword?.zRotation = -20
        sword?.position.x = -40
        
        slash?.setScale(0.5)
        slash?.position.x = 0
    }
    
    func addCharacterBattle(_ position: CGPoint, category: UInt32, contact: UInt32, collision: UInt32, name: String, version: String) {
        
        let character = characterBattle(position, category: category, contact: contact, collision: collision)
        
        let (hpbarinner, hpbarouter) = hpBarCharacterBattle()
        let playerName = playerNameLabel(name: name)
        
        if version == "another" {
            anotherPlayer = character
            anotherPlayerHpBarInner = hpbarinner
            anotherPlayerHpBarOuter = hpbarouter
            self.anotherPlayerNameLabel = playerName
        } else {
            characterNode = character
            hpBarInner = hpbarinner
            hpBarOuter = hpbarouter
            self.playerName = playerName
        }
        
        
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
        character.position = position
        character.setScale(0.3)
        character.physicsBody?.categoryBitMask = category
        character.physicsBody?.contactTestBitMask = contact
        character.physicsBody?.isDynamic = false
        
        addChild(character)
        
        self.dummyRobot = character
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        return
    }
    
    override func update(_ currentTime: TimeInterval) {
        if hpEnemy <= 0 && !ghostAdded {
            ghostAdded = true
            
            let ghostNode = addItem(CGPoint(x: 200, y: 0), imageName: "death_00000")
            startGhostAnimation(ghostNode: ghostNode)
            
            let fadeOutAction = SKAction.fadeOut(withDuration: 1.0)
            dummyRobot?.run(fadeOutAction) {
                self.dummyRobot?.removeFromParent()
            }
        }
        
        gameModel = GameModel(player: characterNode.position, name: gameCenter.localPlayer.displayName, hpBar: [hpBarInner.position, hpBarOuter.position], labelName: playerName.position, sword: swordNode.position, melee: meleeAreaNode.position, slash: slashNode.position, rangeArea: rangeAreaNode.position, angleProjectile: self.angle,  isotherHit: isOtherHit)

        gameCenter.sendGameModel(gameModel)
                
        if gameCenter.dataModel != nil {
            if anotherPlayer != nil {
                anotherPlayer.position = gameCenter.dataModel!.player
                anotherPlayerNameLabel.position = gameCenter.dataModel!.labelName
                anotherPlayerHpBarInner.position = gameCenter.dataModel!.hpBar[0]
                anotherPlayerHpBarOuter.position = gameCenter.dataModel!.hpBar[1]
                anotherPlayerSword.position = gameCenter.dataModel!.sword
                anotherPlayerSlash.position = gameCenter.dataModel!.slash
                anotherPlayerMeleeArea.position = gameCenter.dataModel!.melee
                anotherPlayerRange.position = gameCenter.dataModel!.rangeArea
                
                anotherProjectileNode = addProjectile()
                anotherProjectileNode.position = gameCenter.dataModel!.player
                
                if gameCenter.dataModel!.isotherHit {
                    startSkillAnimation(projectileNode: anotherProjectileNode, imageSet: ["fire_1", "fire_2", "fire_3", "fire_4", "fire_5"], timePerFrame: 0.1)
                    
                    anotherProjectileNode = projectileMove(angle: gameCenter.dataModel!.angleProjectile, projectile: anotherProjectileNode)
                    
                    addChild(anotherProjectileNode)
                }
                
            } else {
                addCharacterBattle(gameCenter.dataModel!.player, category: PhysicsCategory.otherPlayer, contact: PhysicsCategory.none, collision: PhysicsCategory.none, name: gameCenter.dataModel!.name, version: "another")
                anotherPlayerSword = addItem(CGPoint(), imageName: "defaultSword")
                
                anotherPlayerMeleeArea = addItem(CGPoint(), imageName: "meleeArea",isPhysicsBody: true, category: PhysicsCategory.meleeArea, contact: PhysicsCategory.enemy, collision: PhysicsCategory.none)
                
                anotherPlayerRange = addItem(CGPoint(), imageName: "rangeArea",isPhysicsBody: false, category: PhysicsCategory.rangeArea, contact: PhysicsCategory.enemy, collision: PhysicsCategory.none)
                
                anotherPlayerSlash = addItem(CGPoint(), imageName: "slash_00000")

                configureAttackProperties(mele: anotherPlayerMeleeArea, range: anotherPlayerRange, slash: anotherPlayerSlash, sword: anotherPlayerSword)
                
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
