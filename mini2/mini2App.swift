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
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Character.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .modelContainer(sharedModelContainer)
        }
    }
}
