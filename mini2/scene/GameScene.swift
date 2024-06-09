import SpriteKit

class GameScene: SKScene {
    var appleNode: SKSpriteNode?
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
            let actions = [
                SKAction.scale(to: 0.5, duration: 0.5),
                SKAction.scale(to: 1, duration: 0.5)
            ]

            self.appleNode?.run(SKAction.sequence(actions))
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            guard let appleNode = self.appleNode else {
                return
            }
            
            let pVelocity = joystick.velocity;
            let speed = CGFloat(0.12)
            
            appleNode.position = CGPoint(x: appleNode.position.x + (pVelocity.x * speed), y: appleNode.position.y + (pVelocity.y * speed))
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            let actions = [
                SKAction.scale(to: 1.5, duration: 0.5),
                SKAction.scale(to: 1, duration: 0.5)
            ]

            self.appleNode?.run(SKAction.sequence(actions))
        }
        
        rotateJoystick.on(.move) { [unowned self] joystick in
            guard let appleNode = self.appleNode else {
                return
            }

            appleNode.zRotation = joystick.angular
        }
        
        rotateJoystick.on(.end) { [unowned self] _ in
            self.appleNode?.run(SKAction.rotate(byAngle: 3.6, duration: 0.5))
        }

        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true

        addApple(CGPoint(x: frame.midX, y: frame.midY))

        view.isMultipleTouchEnabled = true
        
        // Setup camera
        addChild(cameraNode)
        camera = cameraNode
    }
    
    func addApple(_ position: CGPoint) {
        guard let appleImage = UIImage(named: "apple") else {
            return
        }
        
        let texture = SKTexture(image: appleImage)
        let apple = SKSpriteNode(texture: texture)
        apple.physicsBody = SKPhysicsBody(texture: texture, size: apple.size)
        apple.physicsBody!.affectedByGravity = false
        apple.position = position
        addChild(apple)
        appleNode = apple
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
                addApple(touch.location(in: self))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let appleNode = appleNode else { return }
        cameraNode.position = appleNode.position
    }
}
