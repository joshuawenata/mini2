//
//  CharacterView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 10/06/24.
//

import SwiftUI

struct CharacterView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelWatch
    @Binding var character: Character
    
    @StateObject private var audioManager = AudioManager()
    @State private var audioFiles: [URL] = []
    
    var body: some View {
        ZStack {
            Image("greenbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ZStack{
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Character")
                            .font(.custom("AveriaSerifLibre-Regular", size: 35))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .scaledToFit()
                        NavigationLink(destination: SparksView(character: $character), label: {
                            Text("Sparks")
                                .font(.custom("AveriaSerifLibre-Regular", size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.top, 4)
                                .opacity(0.5)
                                .scaledToFit()
                        })
                        Spacer()
                        NavigationLink(destination: InGameView(character: $character), label: {
                            Image("cancel")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .scaledToFit()
                                .padding(.horizontal, 20)
                                .scaledToFit()
                        })
                        .simultaneousGesture(TapGesture().onEnded {
                            if let url = Bundle.main.url(forResource: "exit", withExtension: "wav") {
                                audioManager.loadAudioFiles(urls: [url])
                                audioManager.play()
                            }
                        })
                    }
                    
                }
                
                Spacer()
                
                
                VStack(alignment: .leading) {
                    
                    Text("Status")
                        .font(.custom("AveriaSerifLibre-Regular", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(height: 50)
                    
                    HStack {
                        HStack {
                            Image("dmg")
                                .resizable()
                                .frame(width: 37, height: 37)
                                .padding(.bottom, 4)
                            Text("\((character.characterBaseAttack)+(character.EquipedWeapon.weaponAttack))")
                                .font(.custom("AveriaSerifLibre-Regular", size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                            Text("\(character.characterBaseHP)")
                                .font(.custom("AveriaSerifLibre-Regular", size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, -5)
                    .padding(.bottom, 30)
                    
                    Text("Clothing")
                        .font(.custom("AveriaSerifLibre-Regular", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .offset(y: -3)
                    
                    Image("clothing")
                        .resizable()
                        .frame(width: 250, height: 50)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                }
                .padding(.bottom, 10)
                .padding(.leading, 50)
                ZStack {
                    Image("femboy")
                        .resizable()
                        .scaledToFit()
                        .offset(y: -75)
                        .frame(maxWidth: 352)
                    
                    VStack {
                        
                        Image("charaIdle")
                            .resizable()
                            .frame(width: 150, height: 200)
                            .padding(.horizontal, 150)
                            .opacity(0)
                        
                        Text("|||Exalted|||")
                            .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .offset(y: -25)
                        
                    }
                }
                
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
