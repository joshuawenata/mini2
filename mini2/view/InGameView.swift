//
//  InGameView.swift
//  mini2
//
//  Created by Timothy Andrian on 06/06/24.
//

import SwiftUI
import SpriteKit

struct InGameView: View {
    let scene = GameScene(size: UIScreen.main.bounds.size)
    
    var body: some View {
        NavigationStack {
            SpriteView(scene: scene).ignoresSafeArea()
        }
    }
}

