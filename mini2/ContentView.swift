//
//  ContentView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 04/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Game Title")
                .font(.system(size: 50))
                .padding()
            VStack(alignment: .leading) {
                Text("What is your name, adventurer?")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Enter your name", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .frame(width: 400)
            }
            .padding()
            Button(action: {
                print("Button was tapped")
            }) {
                Text("Start")
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
