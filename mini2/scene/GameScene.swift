import SpriteKit
import GameKit
import SwiftUI
import SwiftData

class GameScene: SKScene, SKPhysicsContactDelegate {
    //    @ObservedObject var audioManager = AudioManager()
    //    let villageSongNode = SKSpriteNode(color: .red, size: CGSize(width: 200, height: 200))
    //    let riverSound = SKSpriteNode(color: .red, size: CGSize(width: 200, height: 200))
    //    let interactionThresholdDistance: CGFloat = 200
    
    var characterNode: SKSpriteNode!
    var playerName: SKLabelNode!
    var hpBarInner: SKSpriteNode!
    var hpBarOuter: SKSpriteNode!
    var first = true
    let moveJoystick = TLAnalogJoystick(withDiameter: 200)
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    let blacksmithNode = SKSpriteNode(color: .clear, size: CGSize(width: 200, height: 200))
    let battleNode = SKSpriteNode(color: .clear, size: CGSize(width: 300, height: 300))
    var character: Character
    let cameraNode = SKCameraNode()
    let gameCenter = GameCenterManager.shared
    var hiddenTriggered = false
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = UIImage(named: "jStick")
            moveJoystick.handleImage = image
            
            setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Remove" : "Set") stick image"
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let image = UIImage(named: "jSubstrate")
            moveJoystick.baseImage = image
            moveJoystick.baseImage = image
            
            setJoystickSubstrateImageBtn.text = "\(joystickSubstrateImageEnabled ? "Remove" : "Set") substrate image"
        }
    }
    
    init(size: CGSize, character: Character) {
        self.character = character
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeName = contact.bodyA.node?.name ?? contact.bodyB.node?.name else {
            return
        }
        
        touchBuilding(nodeName: nodeName, gameCenter: gameCenter)
    }
    
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        addBackgroundMainIsland(size: size, addChild: addChild)
        let (character, hpbarinner, hpbarouter, playerName) = addCharacter(CGPoint(x: -2000, y: 600), addChild: self.addChild, category: PhysicsCategory.character, contact: PhysicsCategory.none, collision: PhysicsCategory.none, name: gameCenter.localPlayer.displayName, isBattle: false)
        
        characterNode = character
        hpBarInner = hpbarinner
        hpBarOuter = hpbarouter
        self.playerName = playerName
        
        addChild(cameraNode)
        camera = cameraNode
        camera?.position = characterNode.position
        
//        configureJoysticks()
        initBuildingsMainIsland()
        addSongs()
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
    
    override func update(_ currentTime: TimeInterval) {
        if gameCenter.battleView {
            let transition = SKTransition.flipHorizontal(withDuration: 1.0)
            self.view?.presentScene(BattleScene(size: UIScreen.main.bounds.size,character: character), transition: transition)
        }
    }
    
    func initBuildingsMainIsland() {
        //top
        addChild(addBuilding(at: CGPoint(x: -2200, y: 800), imageName: "statueBuilding"))
        addChild(addBuilding(at: CGPoint(x: -2000, y: 800), imageName: "battleBuilding"))
        addChild(addBuilding(at: CGPoint(x: -1800, y: 750), imageName: "npcBattle"))
        
        //left
        let river = addBuildingWithoutPhysics(at: CGPoint(x: -2800, y: 500), imageName: "river1")
        addChild(river)
        startRiverAnimation(riverNode: river)
        let riverSound = SKAudioNode(fileNamed: "river.mp3")
        if let riverSoundNode = riverSound.avAudioNode as? AVAudioPlayerNode {
            riverSoundNode.volume = 0.2
        }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let riverDistance = hypot(river.position.x - self.characterNode.position.x, river.position.y - self.characterNode.position.y)
            if riverDistance < 1500 {
                if riverSound.parent == nil {
                    self.addChild(riverSound)
                }
            } else {
                riverSound.removeFromParent()
            }
        }
        
        addChild(addBuilding(at: CGPoint(x: -2500, y: 800), imageName: "npcFish", isRectangle: true))
        
        let horse = addBuilding(at: CGPoint(x: -2600, y: 400), imageName: "horse_00000")
        horse.setScale(0.35)
        addChild(horse)
        startHorseAnimation(horseNode: horse)
        
        addChild(addBuilding(at: CGPoint(x: -2500, y: 350), imageName: "apple"))
        
        //middle
        addChild(addBuilding(at: CGPoint(x: -2250, y: 400), imageName: "questBuilding"))
        
        let blacksmith = addBuilding(at: CGPoint(x: -2000, y: 400), imageName: "blacksmith_00000", isRectangle: true)
        blacksmith.setScale(0.35)
        addChild(blacksmith)
        startBlacksmithAnimation(blacksmithNode: blacksmith)
        
        addChild(addBuilding(at: CGPoint(x: -1700, y: 400), imageName: "dinerBuilding"))
        
        //bottom
        addChild(addBuilding(at: CGPoint(x: -2200, y: 0), imageName: "npcHouseOne"))
        addChild(addBuilding(at: CGPoint(x: -2000, y: 0), imageName: "npcHouseTwo"))
        addChild(addBuilding(at: CGPoint(x: -1800, y: 0), imageName: "npcHouseThree"))
        addChild(addBuilding(at: CGPoint(x: -1650, y: 50), imageName: "npcHouse"))
        
        //right
        addChild(addBuilding(at: CGPoint(x: -1200, y: 600), imageName: "npcFlower", isRectangle: true))
        let cat = addBuilding(at: CGPoint(x: -1000, y: 600), imageName: "cat")
        addChild(cat)
        cat.setScale(0.7)
        startCatAnimation(catNode: cat)
        
        //down right
        let boss = addBuilding(at: CGPoint(x: 0, y: -200), imageName: "bossAttack_00000")
        boss.setScale(0.4)
        addChild(boss)
        startBossAnimation(bossNode: boss)
        
        let waitSpark = SKAction.wait(forDuration: 36000)
        let addRandomEventSpark = SKAction.run { [weak self] in
            addRandomSparks(addChild: self!.addChild)
        }
        let sequenceSpark = SKAction.sequence([addRandomEventSpark, waitSpark])
        let repeatActionSpark = SKAction.repeatForever(sequenceSpark)
        self.run(repeatActionSpark)
        
        let waitChest = SKAction.wait(forDuration: 3600)
        let addRandomEventChest = SKAction.run { [weak self] in
            addRandomChest(addChild: self!.addChild)
        }
        let sequenceChest = SKAction.sequence([addRandomEventChest, waitChest])
        let repeatActionChest = SKAction.repeatForever(sequenceChest)
        self.run(repeatActionChest)
    }
    
    func configureJoysticks() {
        
        cameraNode.addChild(moveJoystick)
        moveJoystick.position = CGPoint(x: -300, y: -100)
        
        let footstepSound = SKAudioNode(fileNamed: "footsteps.mp3")
        
        moveJoystick.on(.begin) { [unowned self] _ in
            startWalkingAnimation(characterNode: characterNode)
            addChild(footstepSound)
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            let pVelocity = joystick.velocity
            let speed = CGFloat(0.12)
            
            let dx = pVelocity.x * speed
            let dy = pVelocity.y * speed
            
            moveNode(node: characterNode, dx: dx, dy: dy)
            moveNode(node: hpBarInner, dx: dx, dy: dy)
            moveNode(node: hpBarOuter, dx: dx, dy: dy)
            moveNode(label: playerName, dx: dx, dy: dy)
            
            self.cameraNode.position = characterNode.position
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            stopWalkingAnimation(characterNode: characterNode)
            footstepSound.removeFromParent()
        }
        
        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true
        
        view?.isMultipleTouchEnabled = true
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

