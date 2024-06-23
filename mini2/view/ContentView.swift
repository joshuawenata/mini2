//
//  ContentView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 04/06/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query var allQuests: [Quest]
    
    var body: some View {
        OnboardingView()
            .onAppear {
                initQuest(context: context, allQuests: allQuests)
            }
    }
}

func initQuest(context: ModelContext, allQuests: [Quest]) {
    let quests = [
        Quest(id: 1, title: "Deliver items to man with horse", reward: 100, completed: false),
        Quest(id: 2, title: "Collect apple", reward: 50, completed: false),
        Quest(id: 3, title: "Find the lost cat", reward: 150, completed: false),
    ]
    
    for quest in quests {
        if allQuests.contains(where: { $0.title == quest.title }) {
            continue
        }

        context.insert(quest)
    }
}

#Preview {
    InGameView()
}
