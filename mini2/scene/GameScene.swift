import SpriteKit

class GameScene: SKScene {
    var characterNode: SKSpriteNode?
    
    let moveJoystick = 🕹(withDiameter: 100)
    let rotateJoystick = TLAnalogJoystick(withDiameter: 100)
    
    let cameraNode = SKCameraNode()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = .clear
        let background = SKSpriteNode(imageNamed: "mainIsland")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        addCharacter(CGPoint(x: frame.midX, y: frame.midY))
        
        addChild(cameraNode)
        camera = cameraNode
        
        // Calculate half-width of the frame
        let halfWidth = frame.width / 2
        
        // Add move joystick on the left side relative to camera
        cameraNode.addChild(moveJoystick)
        moveJoystick.position = CGPoint(x: -300, y: -100)
        
        // Add rotate joystick on the right side relative to camera
        cameraNode.addChild(rotateJoystick)
        rotateJoystick.position = CGPoint(x: 300, y: -100)
        
        // Configure joysticks
        configureJoysticks()
    }
    
    func configureJoysticks() {
        moveJoystick.on(.begin) { [unowned self] _ in
            self.startWalkingAnimation()
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            
            let pVelocity = joystick.velocity
            let speed = CGFloat(0.12)
            
            // Calculate movement vector
            let dx = pVelocity.x * speed
            let dy = pVelocity.y * speed
            
            // Apply movement to character's position
            characterNode.position.x += dx
            characterNode.position.y += dy
            
            // Update character rotation based on rotate joystick if it's tracking
            if self.rotateJoystick.tracking {
                characterNode.zRotation = self.rotateJoystick.angular - CGFloat.pi / 2
            }
            
            // Adjust camera position to follow character
            self.cameraNode.position = characterNode.position
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            self.stopWalkingAnimation()
        }
        
        rotateJoystick.on(.move) { [unowned self] joystick in
            guard let characterNode = self.characterNode else {
                return
            }
            
            // Update character rotation based on rotate joystick
            characterNode.zRotation = joystick.angular
            
            // Adjust camera position to follow character
            self.cameraNode.position = characterNode.position
        }
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
        
        // Start idle animation
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
        
        // Remove idle animation if it's running
        characterNode.removeAction(forKey: "idle")
    }
    
    func stopWalkingAnimation() {
        guard let characterNode = characterNode else { return }
        
        characterNode.removeAction(forKey: "walk")
        startIdleAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if moveJoystick.contains(location) {
                moveJoystick.touchesBegan(touches, with: event)
            }
            
            if rotateJoystick.contains(location) {
                rotateJoystick.touchesBegan(touches, with: event)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if moveJoystick.contains(location) {
                moveJoystick.touchesMoved(touches, with: event)
            }
            
            if rotateJoystick.contains(location) {
                rotateJoystick.touchesMoved(touches, with: event)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if moveJoystick.contains(location) {
                moveJoystick.touchesEnded(touches, with: event)
            }
            
            if rotateJoystick.contains(location) {
                rotateJoystick.touchesEnded(touches, with: event)
            }
        }
    }

}
