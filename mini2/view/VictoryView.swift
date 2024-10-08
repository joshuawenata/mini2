//
//  VictoryView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 20/06/24.
//

import SwiftUI

struct VictoryView: View {
    
    @StateObject private var audioManager = AudioManager()
    @State private var audioFiles: [URL] = []
    
    var items = Array(0...9)
    @Binding var character: Character
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("victorybg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    VStack {
                        Text("You received")
                            .font(.custom("AveriaSerifLibre-Regular", size: 50))
                            .foregroundColor(.white)
                            .padding()
                            .frame(height: 50)
                            .padding(.bottom, 20)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(items, id: \.self) { item in
                                    Rectangle()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                        .frame(width: 260, height: 50)
                        .padding(.vertical, 20)
                        
                        NavigationLink(destination: InGameView(character: $character), label: {
                            ZStack {
                                Image("button")
                                    .resizable()
                                    .frame(width: 200, height: 70)
                                Text("Finish")
                                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                    .foregroundColor(.white)
                            }
                        })
                        .padding(.top, 20)
                        .simultaneousGesture(TapGesture().onEnded {
                            if let url = Bundle.main.url(forResource: "interaction", withExtension: "wav") {
                                audioManager.loadAudioFiles(urls: [url])
                                audioManager.play()
                            }
                        })
                    }
                }
                .padding(.horizontal, 20)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
                if let url = Bundle.main.url(forResource: "win", withExtension: "wav") {
                    audioManager.loadAudioFiles(urls: [url])
                    audioManager.play()
            }

        }
    }
}
