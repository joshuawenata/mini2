//
//  PlayerDataModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 12/06/24.
//

import Foundation

class PlayerPositionModel: Identifiable, Codable {
    var uuid: UUID = .init()
    var name: String?
    var xPosition: Double?
    var yPosition: Double?
    
    init(uuid: UUID, name: String?, xPosition: Double?, yPosition: Double?) {
        self.uuid = uuid
        self.name = name
        self.xPosition = xPosition
        self.yPosition = yPosition
    }
    
    func data() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
