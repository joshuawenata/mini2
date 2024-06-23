//
//  VariableManager.swift
//  mini2
//
//  Created by Raphael on 20/06/24.
//

import Foundation
import SwiftUI
import SwiftData

class VariableManager: ObservableObject {
    static let shared = VariableManager()
    
    @Published var touchBuilding: String = ""
    @Published var interactionButtonHidden: Bool = true
}
