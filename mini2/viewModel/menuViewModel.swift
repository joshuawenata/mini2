import Foundation
import SpriteKit

class InteractiveMenuNode: SKSpriteNode {
    var onClick: (() -> Void)?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick?()
    }
}

func addMenu(at position: CGPoint, imageName: String, onClick: (() -> Void)? = nil) -> InteractiveMenuNode {
    let menu = InteractiveMenuNode(imageNamed: imageName)
    menu.position = position
    menu.setScale(0.3)
    menu.zPosition = 1
    menu.isUserInteractionEnabled = true
    menu.onClick = onClick
    
    return menu
}
