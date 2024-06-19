//
//  SendingDataModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 12/06/24.
//

import Foundation

class BattleDataModel: Identifiable, Encodable, Decodable {
    var player: PlayerPositionModel
    var data: Data
    
//    init(name: String, data: Data) {
//        self.name = name
//        self.data = data
//    }
}
