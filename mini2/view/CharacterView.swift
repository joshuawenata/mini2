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
    
    var body: some View {
        ZStack {
            Image("greenbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Text("Character")
                        .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaledToFit()
                    NavigationLink(destination: SparksView(character: $character), label: {
                        Text("Sparks")
                            .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
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
                }
                .padding(.horizontal, 15)
                .padding(.top)
                
                Spacer()
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Status")
                            .font(.custom("AveriaSerifLibre-Regular", size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(height: 50)
                        
                        HStack {
                            HStack {
                                Image("dmg")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("\((character.characterBaseAttack)+(character.EquipedWeapon.weaponAttack))")
                                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                Text("\(character.characterBaseHP)")
                                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        
                        Text("Clothing")
                            .font(.custom("AveriaSerifLibre-Regular", size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        Image("clothing")
                            .resizable()
                            .frame(width: 250, height: 50)
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                    }
                    .padding(.bottom, -10)
                    ZStack {
                        VStack {
                            
                            Image("charaIdle")
                                .resizable()
                                .frame(width: 150, height: 200)
                                .padding(.horizontal, 150)
                                .opacity(0)
                            
                            Text("|||Exalted|||")
                                .font(.custom("AveriaSerifLibre-Regular", size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .frame(height: 50)
                            
                        }
                        Image("femboy")
                            .frame(width: 200, height: 200)
                            .offset(y: -45)
                    }
                    
                    
                }
                
            }
            .padding(.horizontal, 50)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
