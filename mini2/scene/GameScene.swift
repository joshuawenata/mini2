import SpriteKit
import GameKit
import SwiftUI
import SwiftData

class GameScene: SKScene, SKPhysicsContactDelegate {
    var characterNode: SKSpriteNode!
    var first = true
    let moveJoystick = TLAnalogJoystick(withDiameter: 200)
    
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    
    let blacksmithNode = SKSpriteNode(color: .clear, size: CGSize(width: 200, height: 200))
    let battleNode = SKSpriteNode(color: .clear, size: CGSize(width: 300, height: 300))
    let interactionThresholdDistance: CGFloat = 200
    
    let cameraNode = SKCameraNode()
    
    let gameCenter = GameCenterManager.shared
    let battleScene = BattleScene(size: UIScreen.main.bounds.size)
    var hiddenTriggered = false
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = UIImage(named: "jStick")
            moveJoystick.handleImage = image
            
            setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Remove" : "Set") stick image"
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeName = contact.bodyA.node?.name ?? contact.bodyB.node?.name else {
            return
        }
        
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

    func didEnd(_ contact: SKPhysicsContact) {
        if(!hiddenTriggered){
            self.hiddenTriggered = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                VariableManager.shared.interactionButtonHidden = true
                self.hiddenTriggered = false
            }
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let image = UIImage(named: "jSubstrate")
            moveJoystick.baseImage = image
            
            setJoystickSubstrateImageBtn.text = "\(joystickSubstrateImageEnabled ? "Remove" : "Set") substrate image"
        }
    }
    
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = .clear
        let background = SKSpriteNode(imageNamed: "mainIsland")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        addCharacter(CGPoint(x: frame.midX, y: frame.midY))
        
        configureJoysticks()
        
        //top
        addChild(addBuilding(at: CGPoint(x: -1700, y: 300), imageName: "statueBuilding"))
        addChild(addBuilding(at: CGPoint(x: -1500, y: 300), imageName: "battleBuilding"))
        addChild(addBuilding(at: CGPoint(x: -1300, y: 250), imageName: "npcBattle"))
        
        //left
        let river = addBuildingWithoutPhysics(at: CGPoint(x: -3300, y: 1000), imageName: "river1")
        river.setScale(0.75)
        addChild(river)
        startRiverAnimation(riverNode: river)
        
        addChild(addBuilding(at: CGPoint(x: -2000, y: 300), imageName: "npcFish"))
        
        let horse = addBuilding(at: CGPoint(x: -2200, y: -100), imageName: "horse_00000")
        horse.setScale(0.35)
        addChild(horse)
        startHorseAnimation(horseNode: horse)
        
        addChild(addBuilding(at: CGPoint(x: -2100, y: -150), imageName: "apple"))
        
        //middle
        addChild(addBuilding(at: CGPoint(x: -1750, y: -100), imageName: "questBuilding"))
        
        let blacksmith = addBuilding(at: CGPoint(x: -1500, y: -100), imageName: "blacksmith_00000")
        blacksmith.setScale(0.35)
        addChild(blacksmith)
        startBlacksmithAnimation(blacksmithNode: blacksmith)
        
        addChild(addBuilding(at: CGPoint(x: -1200, y: -100), imageName: "dinerBuilding"))
        
        //bottom
        addChild(addBuilding(at: CGPoint(x: -1700, y: -500), imageName: "npcHouseOne"))
        addChild(addBuilding(at: CGPoint(x: -1500, y: -500), imageName: "npcHouseTwo"))
        addChild(addBuilding(at: CGPoint(x: -1300, y: -500), imageName: "npcHouseThree"))
        addChild(addBuilding(at: CGPoint(x: -1150, y: -550), imageName: "npcHouse"))
        
        //right
        addChild(addBuilding(at: CGPoint(x: -800, y: 100), imageName: "npcFlower"))
        let cat = addBuilding(at: CGPoint(x: -600, y: 100), imageName: "cat")
        addChild(cat)
        cat.setScale(0.7)
        startCatAnimation(catNode: cat)
        
        //down right
        let boss = addBuilding(at: CGPoint(x: 3000, y: -700), imageName: "bossAttack_00000")
        boss.setScale(0.4)
        addChild(boss)
        startBossAnimation(bossNode: boss)
        
        let waitSpark = SKAction.wait(forDuration: 36000)
        let addRandomEventSpark = SKAction.run { [weak self] in
            self?.addRandomSparks()
        }
        let sequenceSpark = SKAction.sequence([addRandomEventSpark, waitSpark])
        let repeatActionSpark = SKAction.repeatForever(sequenceSpark)
        self.run(repeatActionSpark)
        
        let waitChest = SKAction.wait(forDuration: 3600)
        let addRandomEventChest = SKAction.run { [weak self] in
            self?.addRandomChest()
        }
        let sequenceChest = SKAction.sequence([addRandomEventChest, waitChest])
        let repeatActionChest = SKAction.repeatForever(sequenceChest)
        self.run(repeatActionChest)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max) * (max - min) + min
    }
    
    func addRandomSparks() {
        let sparksPosition = CGPoint(x: random(min: -1500, max: -500), y: random(min: -500, max: 500))
        let sparks = addBuilding(at: sparksPosition, imageName: "sparks")
        
        addChild(sparks)
    }
    
    func addRandomChest() {
        let chestPosition = CGPoint(x: random(min: -1800, max: -1200), y: random(min: 100, max: 200))
        let chest = addBuilding(at: chestPosition, imageName: "chest_opened")
        
        addChild(chest)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameCenter.battleView {
            let transition = SKTransition.flipHorizontal(withDuration: 1.0)
            self.view?.presentScene(battleScene, transition: transition)
        }
    }
    
    func configureJoysticks() {
        addChild(cameraNode)
        camera = cameraNode
        
        cameraNode.addChild(moveJoystick)
        moveJoystick.position = CGPoint(x: -300, y: -100)
        
        moveJoystick.on(.begin) { [unowned self] _ in
            startWalkingAnimation(characterNode: characterNode)
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
            
            self.cameraNode.position = characterNode.position
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            stopWalkingAnimation(characterNode: characterNode)
        }
        
        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true
        
        view?.isMultipleTouchEnabled = true
    }
    
    func addCharacter(_ position: CGPoint) {
        guard let characterImage = UIImage(named: "charaIdle") else {
            return
        }
        
        let texture = SKTexture(image: characterImage)
        let character = SKSpriteNode(texture: texture)
        character.physicsBody = SKPhysicsBody(texture: texture, size: character.size)
        character.physicsBody?.affectedByGravity = false
        character.position = CGPoint(x: -1500, y: 0)
        character.physicsBody?.allowsRotation = false
        character.setScale(0.3)
        character.physicsBody?.categoryBitMask = CollisionCategory.building.rawValue
        character.physicsBody?.collisionBitMask = CollisionCategory.building.rawValue
        character.physicsBody?.contactTestBitMask = CollisionCategory.building.rawValue
        character.physicsBody?.isDynamic = true
        
        addChild(character)
        characterNode = character
                
        startIdleAnimation(characterNode: characterNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtPoint = nodes(at: location)
            for node in nodesAtPoint {
                if let nodeName = node.name {
                    print("Touched building: \(nodeName)")
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if moveJoystick.contains(location) {
                moveJoystick.touchesMoved(touches, with: event)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if moveJoystick.contains(location) {
                moveJoystick.touchesEnded(touches, with: event)
            }
        }
    }
    
    func createPath(from start: CGPoint, to destination: CGPoint) -> CGMutablePath {
        let pathToMove = CGMutablePath()
        pathToMove.move(to: start)
        pathToMove.addLine(to: destination)
        return pathToMove
    }
    
    func presentView(view: AnyView) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first {
            let hostingController = UIHostingController(rootView: view)
            keyWindow.rootViewController?.present(hostingController, animated: true, completion: nil)
        }
    }
    
    
}

enum CollisionCategory: UInt32 {
    case building = 1
}

