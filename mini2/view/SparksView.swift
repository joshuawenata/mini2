//
//  SparksView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 12/06/24.
//

import SwiftUI

struct SparksView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var audioManager = AudioManager()
    @State private var audioFiles: [URL] = []

    @Binding var character: Character
    @State private var currentItem: Any?
        
    var weapons: [WeaponModel] {
        character.getCollectedWeapons()
    }
    var skills: [SkillModel] {
        character.getCollectedSkills()
    }
    
    init(character: Binding<Character>) {
        self._character = character
        // Initialize currentItem based on collected items
        if let firstWeapon = character.wrappedValue.getCollectedWeapons().first {
            self._currentItem = State(initialValue: firstWeapon)
        } else if let firstSkill = character.wrappedValue.getCollectedSkills().first {
            self._currentItem = State(initialValue: firstSkill)
        } else {
            fatalError("No items collected")
        }
    }
    
    var updateCurrentItem: (Any) -> Void {
        return { item in
            if let weapon = item as? WeaponModel {
                character.EquipedWeapon = weapon
            } else if let skill = item as? SkillModel {
                character.EquipedSkill = skill
            }
        }
    }
    
    let itemsPerRow = 4
    
    var rows: Int {
        return (character.getTotalItem() + itemsPerRow - 1) / itemsPerRow
    }
    
    var body: some View {
        ZStack {
            Image("greenbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    NavigationLink(destination: CharacterView(character: $character), label: {
                        Text("Character")
                            .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .scaledToFit()
                    })
                    Text("Sparks")
                        .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .scaledToFit()
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
                .padding(.bottom, 20)
                .padding(.top, 20)
                
                Spacer()
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                                                        
                            Text("Equipped")
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(height: 50)
                            
                            Image(character.EquipedWeapon.weaponImage)
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                                .padding(.horizontal)
                            
                            Image(character.EquipedSkill.skillImage)
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                        }
                        .padding(.vertical, 30)
                        
                        Spacer()
                        
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(0..<rows, id: \.self) { row in
                                    HStack(spacing: 20) {
                                        ForEach(0..<itemsPerRow, id: \.self) { column in
                                            let index = row * itemsPerRow + column
                                            if index < character.collectedWeapon.count {
                                                Button(action: {
                                                    updateCurrentItem(character.collectedWeapon[index])
                                                }) {
                                                    Image(character.collectedWeapon[index].weaponImage)
                                                        .frame(width: 80, height: 80)
                                                        .padding(.horizontal, 5)
                                                }
                                            } else if index - character.collectedWeapon.count < character.collectedSkill.count {
                                                Button(action: {
                                                    updateCurrentItem(character.collectedSkill[index - character.collectedWeapon.count])
                                                }) {
                                                    Image(character.collectedSkill[index - character.collectedWeapon.count].skillImage)
                                                        .frame(width: 80, height: 80)
                                                        .padding(.horizontal, 5)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        
                    }
                    
                    Spacer()
                    
                    VStack (alignment: .center) {
                        
                        HStack {
                            
                            if let weapon = currentItem as? WeaponModel {
                                Text(weapon.weaponName)
                                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .frame(height: 50)
                            } else if let skill = currentItem as? SkillModel {
                                Text(skill.skillName)
                                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .frame(height: 50)
                            }
    
                            Image("dmg")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            if let weapon = currentItem as? WeaponModel {
                                Text("+"+String(weapon.weaponAttack))
                                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(height: 50)
                            } else if let skill = currentItem as? SkillModel {
                                Text("+"+String(skill.skillDamage))
                                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(height: 50)
                            }
                            
                        }
                        
                        if let weapon = currentItem as? WeaponModel {
                            Image(weapon.weaponImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                .scaledToFit()
                        } else if let skill = currentItem as? SkillModel {
                            Image(skill.skillImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                .scaledToFit()
                        }
                        
                        HStack {
                            
                            ZStack(alignment: .center) {
                                
                                Image("button")
                                    .resizable()
                                    .frame(width: 140, height: 70)
                                    .scaledToFit()
                                    .padding(.leading, 10)
                                
                                Text("Equip")
                                    .font(.custom("AveriaSerifLibre-Regular", size: 25))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                    .padding(.leading, 10)
                                
                            }
                            
                            ZStack(alignment: .center) {
                                
                                Image("button")
                                    .resizable()
                                    .frame(width: 140, height: 70)
                                    .scaledToFit()
                                
                                HStack {
                                    
                                    Image("upgrade")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                        .scaledToFit()
                                    
                                    Text("1000")
                                        .font(.custom("AveriaSerifLibre-Regular", size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Image("gold")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .scaledToFit()
                                    
                                }
                                .padding()
                                
                            }
                            
                        }
                        
                    }
                    .padding()
                    
                }
                    
            }
            .padding(.horizontal, 50)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
