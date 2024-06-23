//
//  CollectableItem.swift
//  mini2
//
//  Created by Timothy Andrian on 23/06/24.
//

import Foundation

class CollectableItem: Codable, Identifiable {
    var id = UUID()
    var itemName: String
    var itemPrice: Int
    var itemDescription: String
    var itemImage: String
    var itemJoystickImage: String
    
    init(id: UUID = UUID(), itemName: String, itemPrice: Int, itemDescription: String, itemImage: String, itemJoystickImage: String) {
        self.id = id
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemDescription = itemDescription
        self.itemImage = itemImage
        self.itemJoystickImage = itemJoystickImage
    }
}
