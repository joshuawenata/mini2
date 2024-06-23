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
    
    let shopNode = SKSpriteNode(color: .clear, size: CGSize(width: 200, height: 200))
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
            case "shopBuilding":
                VariableManager.shared.interactionButtonHidden = false
                VariableManager.shared.touchBuilding = "shopBuilding"
            case "dinerBuilding":
                VariableManager.shared.interactionButtonHidden = false
                VariableManager.shared.touchBuilding = "shopBuilding"
            case "questBuilding":
                VariableManager.shared.interactionButtonHidden = false
                VariableManager.shared.touchBuilding = "questBuilding"
            case "npcHorse":
                VariableManager.shared.interactionButtonHidden = false
                VariableManager.shared.touchBuilding = "npcHorse"
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
        addChild(addBuilding(at: CGPoint(x: -200, y: 300), imageName: "statueBuilding"))
        addChild(addBuilding(at: CGPoint(x: 0, y: 300), imageName: "battleBuilding"))
        addChild(addBuilding(at: CGPoint(x: 200, y: 250), imageName: "npcBattle"))
        
        //left
        addChild(addBuilding(at: CGPoint(x: -1500, y: 500), imageName: "river"))
        addChild(addBuilding(at: CGPoint(x: -500, y: 300), imageName: "npcFish"))
        addChild(addBuilding(at: CGPoint(x: -700, y: -100), imageName: "npcHorse"))
        
        //middle
        addChild(addBuilding(at: CGPoint(x: -250, y: -100), imageName: "questBuilding"))
        addChild(addBuilding(at: CGPoint(x: 0, y: -100), imageName: "shopBuilding"))
        addChild(addBuilding(at: CGPoint(x: 300, y: -100), imageName: "dinerBuilding"))
        
        //bottom
        addChild(addBuilding(at: CGPoint(x: -200, y: -500), imageName: "npcHouseOne"))
        addChild(addBuilding(at: CGPoint(x: 0, y: -500), imageName: "npcHouseTwo"))
        addChild(addBuilding(at: CGPoint(x: 200, y: -500), imageName: "npcHouseThree"))
        addChild(addBuilding(at: CGPoint(x: 350, y: -550), imageName: "npcHouse"))
        
        //right
        addChild(addBuilding(at: CGPoint(x: 700, y: 100), imageName: "npcFlower"))
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
        character.position = CGPoint(x: 0, y: 0)
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

