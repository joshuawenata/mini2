//
//  BackpackView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 11/06/24.
//

import SwiftUI
import SwiftData

struct BackpackView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var audioManager = AudioManager()
    @State private var audioFiles: [URL] = []

    private let itemsPerRow = 6
    @Binding var character: Character

    private var rows: Int {
        return ( character.getTotalItem() + itemsPerRow - 1) / itemsPerRow
    }

    var body: some View {
        ZStack {
            Image("greenbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Backpack")
                        .font(.custom("AveriaSerifLibre-Regular", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaledToFit()
                        .padding()
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        if let url = Bundle.main.url(forResource: "exit", withExtension: "wav") {
                            audioManager.loadAudioFiles(urls: [url])
                            audioManager.play()
                        }
                    }) {
                        Image("cancel")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFit()
                            .padding(.horizontal, 20)
                            .scaledToFit()
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.leading, 10)
                
                Spacer()
                
                ScrollView {
                    if character.getTotalItem() > 6 {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(0..<rows, id: \.self) { row in
                                HStack(spacing: 20) {
                                    ForEach(0..<itemsPerRow, id: \.self) { column in
                                        let index = row * itemsPerRow + column
                                        if index < character.getTotalItem() {
                                            if index < character.collectedWeapon.count {
                                                Image(character.collectedWeapon[index].weaponImage)
                                            } else {
                                                let skillIndex = index - character.collectedWeapon.count
                                                Image(character.collectedSkill[skillIndex].skillImage)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    } else {
                        HStack(spacing: 20) {
                            ForEach(character.collectedWeapon) { weapon in
                                Image(weapon.weaponImage)
                            }
                            ForEach(character.collectedSkill) { skill in
                                Image(skill.skillImage)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 80)
            .padding(.trailing, -20)
        }
        .navigationBarBackButtonHidden(true)
    }
}
