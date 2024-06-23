//
//  mini2App.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 04/06/24.
//

import SwiftUI
import SwiftData

@main
struct mini2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    Quest.self
                ])
        }
    }
}
