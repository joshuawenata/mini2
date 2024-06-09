import SpriteKit

class GameScene: SKScene {
    var characterNode: SKSpriteNode?
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    
    let moveJoystick = 🕹(withDiameter: 100)
    let rotateJoystick = TLAnalogJoystick(withDiameter: 100)
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = joystickStickImageEnabled ? UIImage(named: "jStick") : nil
            moveJoystick.handleImage = image
            rotateJoystick.handleImage = image
            setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Remove" : "Set") stick image"
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let image = joystickSubstrateImageEnabled ? UIImage(named: "jSubstrate") : nil
            moveJoystick.baseImage = image
            rotateJoystick.baseImage = image
            setJoystickSubstrateImageBtn.text = "\(joystickSubstrateImageEnabled ? "Remove" : "Set") substrate image"
        }
    }

    let cameraNode = SKCameraNode()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = .clear
        
        let background = SKSpriteNode(imageNamed: "mainIsland")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)

        let moveJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: 0, y: 0, width: frame.midX, height: frame.height))
        moveJoystickHiddenArea.joystick = moveJoystick
        moveJoystickHiddenArea.strokeColor = .clear
        moveJoystick.isMoveable = true
        addChild(moveJoystickHiddenArea)
        
        let rotateJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: frame.midX, y: 0, width: frame.midX, height: frame.height))
        rotateJoystickHiddenArea.strokeColor = .clear
        rotateJoystickHiddenArea.joystick = rotateJoystick
        addChild(rotateJoystickHiddenArea)
        
        moveJoystick.on(.begin) { [unowned self] _ in
            self.startWalkingAnimation()
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            
            let pVelocity = joystick.velocity
            let speed = CGFloat(0.12)
            
            characterNode.position = CGPoint(x: characterNode.position.x + (pVelocity.x * speed), y: characterNode.position.y + (pVelocity.y * speed))
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            self.stopWalkingAnimation()
        }
        
        rotateJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }

            characterNode.zRotation = joystick.angular
        }
        
        rotateJoystick.on(.end) { [unowned self] _ in
            self.characterNode?.run(SKAction.rotate(byAngle: 3.6, duration: 0.5))
        }

        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true

        addcharacter(CGPoint(x: frame.midX, y: frame.midY))

        view.isMultipleTouchEnabled = true
        
        addChild(cameraNode)
        camera = cameraNode
    }
    
    func addcharacter(_ position: CGPoint) {
        guard let characterImage = UIImage(named: "charaIdle") else {
            return
        }
        
        let texture = SKTexture(image: characterImage)
        let character = SKSpriteNode(texture: texture)
        character.physicsBody = SKPhysicsBody(texture: texture, size: character.size)
        character.physicsBody!.affectedByGravity = false
        character.position = position
        character.setScale(0.3)
        addChild(character)
        characterNode = character
    }
    
    func startWalkingAnimation() {
        guard let characterNode = characterNode else { return }
        
        let walkTextures = [SKTexture(imageNamed: "charaIdle"), SKTexture(imageNamed: "charaWalk")]
        let walkAnimation = SKAction.animate(with: walkTextures, timePerFrame: 0.2, resize: false, restore: true)
        let repeatWalk = SKAction.repeatForever(walkAnimation)
        characterNode.run(repeatWalk, withKey: "walk")
    }
    
    func stopWalkingAnimation() {
        guard let characterNode = characterNode else { return }
        
        characterNode.removeAction(forKey: "walk")
        characterNode.texture = SKTexture(imageNamed: "charaIdle")
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
                addcharacter(touch.location(in: self))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let characterNode = characterNode else { return }
        cameraNode.position = characterNode.position
    }
}
