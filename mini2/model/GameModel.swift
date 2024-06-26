//
//  SendDataGameCenter.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 21/06/24.
//

import Foundation
import GameKit

struct GameModel: Codable {
    var player: CGPoint
    var name: String
    var hpBar: [CGPoint]
    var labelName: CGPoint
    var sword: CGPoint
    var melee: CGPoint
    var slash: CGPoint
    var rangeArea: CGPoint
    var angleProjectile: CGFloat
    var isotherHit: Bool
    
    func encode() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    static func decode(data: Data) -> GameModel? {
        return try? JSONDecoder().decode(GameModel.self, from: data)
    }
}
