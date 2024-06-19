import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    var characterNode: SKSpriteNode?
    var first = true
    let moveJoystick = 🕹(withDiameter: 100)
    var isWallContanct = false
    
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    
    let cameraNode = SKCameraNode()
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = UIImage(named: "jStick")
            moveJoystick.handleImage = image
            setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Remove" : "Set") stick image"
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Begin!")
        isWallContanct = true
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("Ending!")
        isWallContanct = false
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
        
        addChild(addBuilding(at: CGPoint(x: 0, y: 100), imageName: "battleBuilding"))
        addChild(addBuilding(at: CGPoint(x: -400, y: 0), imageName: "shopBuilding"))
        
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
        return
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
}

enum CollisionCategory: UInt32 {
    case building = 1
}
