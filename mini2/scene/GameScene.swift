import SpriteKit
import SwiftUI

class GameScene: SKScene {
    var characterNode: SKSpriteNode?
    
    let moveJoystick = 🕹(withDiameter: 100)
    let rotateJoystick = TLAnalogJoystick(withDiameter: 100)
    
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    
    let cameraNode = SKCameraNode()
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = UIImage(named: "jStick")
            moveJoystick.handleImage = image
            rotateJoystick.handleImage = image
            setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Remove" : "Set") stick image"
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let image = UIImage(named: "jSubstrate")
            moveJoystick.baseImage = image
            rotateJoystick.baseImage = image
            setJoystickSubstrateImageBtn.text = "\(joystickSubstrateImageEnabled ? "Remove" : "Set") substrate image"
        }
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
        
        cameraNode.addChild(rotateJoystick)
        rotateJoystick.position = CGPoint(x: 300, y: -100)
        
        moveJoystick.on(.begin) { [unowned self] _ in
            self.startWalkingAnimation()
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
            
            if self.rotateJoystick.tracking {
                characterNode.zRotation = self.rotateJoystick.angular - CGFloat.pi / 2
            }
            
            self.cameraNode.position = characterNode.position
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            self.stopWalkingAnimation()
        }
        
        rotateJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            
            characterNode.zRotation = joystick.angular
            self.cameraNode.position = characterNode.position
        }
        
        rotateJoystick.on(.end) { [unowned self] _ in
            self.characterNode?.zRotation = 0
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
        character.physicsBody!.affectedByGravity = false
        character.position = CGPoint(x: 0, y: 0)
        character.setScale(0.3)
        addChild(character)
        characterNode = character
        
        startIdleAnimation()
    }
    
    func startIdleAnimation() {
        guard let characterNode = characterNode else { return }
        
        let idleTextures = [SKTexture(imageNamed: "charaIdle")]
        let idleAnimation = SKAction.animate(with: idleTextures, timePerFrame: 0.2, resize: false, restore: true)
        let repeatIdle = SKAction.repeatForever(idleAnimation)
        characterNode.run(repeatIdle, withKey: "idle")
    }
    
    func startWalkingAnimation() {
        guard let characterNode = characterNode else { return }
        
        let walkTextures = [SKTexture(imageNamed: "charaWalk"), SKTexture(imageNamed: "charaIdle")]
        let walkAnimation = SKAction.animate(with: walkTextures, timePerFrame: 0.2, resize: false, restore: true)
        let repeatWalk = SKAction.repeatForever(walkAnimation)
        characterNode.run(repeatWalk, withKey: "walk")
        
        characterNode.removeAction(forKey: "idle")
    }
    
    func stopWalkingAnimation() {
        guard let characterNode = characterNode else { return }
        
        characterNode.removeAction(forKey: "walk")
        startIdleAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let node = atPoint(touch.location(in: self))
            
            switch node {
            case setJoystickStickImageBtn:
                joystickStickImageEnabled = !joystickStickImageEnabled
            case setJoystickSubstrateImageBtn:
                joystickSubstrateImageEnabled = !joystickSubstrateImageEnabled
            default:
                joystickStickImageEnabled = !joystickStickImageEnabled
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
}
