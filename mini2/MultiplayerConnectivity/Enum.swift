//
//  Enum.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 12/06/24.
//

import Foundation

enum PlayerAuthState: String{
    case authenticating = "Loading ....."
    case unauthenticated = "Please sign in to Game Center to play."
    case authenticated = ""
    
    case error = "There was an error"
    case restricted = "You're not allowed!"
    
}

enum SendingData: String {
    case playerPosition = "player position"
}
