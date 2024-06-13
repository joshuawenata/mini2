import SpriteKit
import SwiftUI

class GameScene: SKScene {
    var characterNode: SKSpriteNode?
    var first = true
    var swordNode: SKSpriteNode?
    var meleeAreaNode: SKSpriteNode?
    var slashNode: SKSpriteNode?
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
        swordNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "defaultSword")
        meleeAreaNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "meleeArea")
        slashNode = addItem(CGPoint(x: frame.midX, y: frame.midY), imageName: "slash_00000")
        meleeAreaNode?.isHidden = true
        slashNode?.isHidden = true
        
        swordNode?.zRotation = -20
        swordNode?.position.x = -40
        
        slashNode?.setScale(1.0)
        slashNode?.position.x = 0
        
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
            
            swordNode?.position.x += dx
            swordNode?.position.y += dy
            
            meleeAreaNode?.position.x += dx
            meleeAreaNode?.position.y += dy
            
            slashNode?.position.x += dx
            slashNode?.position.y += dy
            
            self.cameraNode.position = characterNode.position
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            stopWalkingAnimation(characterNode: characterNode)
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
            slashNode.position.x += 60
            meleeAreaNode.setScale(0.5)
            meleeAreaNode.anchorPoint = CGPoint(x: 1.0, y: 0)
        }
        
        rotateJoystick.on(.move) { [unowned self] joystick in
            guard let meleeAreaNode = self.meleeAreaNode else {
                return
            }
            guard let slashNode = self.slashNode else {
                return
            }
            meleeAreaNode.zRotation = joystick.angular
            slashNode.zRotation = joystick.angular
        }
        
        rotateJoystick.on(.end) { [unowned self] _ in
            startAttackAnimation(characterNode: characterNode)
            guard let swordNode = self.swordNode else {
                return
            }
            guard let meleeAreaNode = self.meleeAreaNode else {
                return
            }
            guard let slashNode = self.slashNode else {
                return
            }
            slashNode.isHidden = false
            slashNode.position.x -= 60
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
        
        startIdleAnimation(characterNode: characterNode)
    }
    
    func addItem(_ position: CGPoint, imageName: String, isPhysicsBody: Bool = false) -> SKSpriteNode {
        guard let itemImage = UIImage(named: imageName) else {
            return SKSpriteNode()
        }
        
        let texture = SKTexture(image: itemImage)
        let item = SKSpriteNode(texture: texture)
        if(isPhysicsBody){
            item.physicsBody = SKPhysicsBody(texture: texture, size: item.size)
            item.physicsBody = SKPhysicsBody(texture: texture, size: item.size)
            item.physicsBody!.affectedByGravity = false
        }
        item.position = CGPoint(x: -60, y: 0)
        item.setScale(0.3)
        addChild(item)
        
        return item
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
