//
//  Quest.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 21/06/24.
//

import SwiftData

@Model
class Quest {
    @Attribute(.unique) var id: Int
    var title: String
    var reward: Int
    var completed: Bool
    
    init(id: Int, title: String, reward: Int, completed: Bool) {
        self.id = id
        self.title = title
        self.reward = reward
        self.completed = completed
    }
}
