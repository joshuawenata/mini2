//
//  SparksView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 12/06/24.
//

import SwiftUI

struct SparksView: View {
    @Environment(\.presentationMode) var presentationMode
    let itemsPerRow = 4
    @State var isChoosingSkill = false
    @State var newWeapon = WeaponModel(weaponName: "Sword", weaponPrice: 0, weaponAttack: 10, weaponImage: "sword 1",weaponJoystickImage: "sword_joystick")
    @State var newSkill  = SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillImage: "fireball",skillJoystickImage: "fireballIcon")
    @Binding var character: Character
    
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
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 15)
                
                Spacer()
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                                                        
                            Text("Equipped")
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .frame(height: 50)
                            
                            Button {
                                isChoosingSkill = false
                            } label: {
                                Image(character.EquipedWeapon.weaponImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(.horizontal)
                            }
                            
                            Button {
                                isChoosingSkill = true
                            } label: {
                                Image(character.EquipedSkill.skillImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding(.vertical, 20)
                        
                        Spacer()
                        
                        ScrollView {
                            if character.getTotalItem() > 4 {
                                VStack(alignment: .leading, spacing: 20) {
                                    ForEach(0..<rows, id: \.self) { row in
                                        HStack(spacing: 20) {
                                            ForEach(0..<itemsPerRow, id: \.self) { column in
                                                let index = row * itemsPerRow + column
                                                if index < character.getTotalItem() {
                                                    if index < character.collectedWeapon.count {
                                                        Button {
                                                            newWeapon = character.collectedWeapon[index]
                                                        } label: {
                                                            Image(character.collectedWeapon[index].weaponImage)
                                                                .scaledToFit()
                                                                .frame(width: 80, height: 80)
                                                                .padding(.horizontal, 5)
                                                        }
                                                    } else {
                                                        let skillIndex = index - character.collectedWeapon.count
                                                        Button {
                                                            newSkill = character.collectedSkill[index]
                                                        } label: {
                                                            Image(character.collectedSkill[skillIndex].skillImage)
                                                                .scaledToFit()
                                                                .frame(width: 80, height: 80)
                                                                .padding(.horizontal, 5)
                                                        }
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
                                        Button {
                                            newWeapon = weapon
                                        } label: {
                                            Image(weapon.weaponImage)
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                                .padding(.horizontal, 5)
                                        }
                                    }
                                    ForEach(character.collectedSkill) { skill in
                                        Button {
                                            newSkill = skill
                                        } label: {
                                            Image(skill.skillImage)
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                                .padding(.horizontal, 5)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        
                    }
                    
                    VStack (alignment: .center) {
                        
                        HStack {
                            
                            Text("sword")
                                .font(.custom("AveriaSerifLibre-Regular", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .frame(height: 50)
    
                            Image("dmg")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Text("+\(isChoosingSkill ? newWeapon.weaponAttack : newSkill.skillDamage)")
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(height: 50)
                            
                        }
                        
                        if isChoosingSkill {
                            Image(newSkill.skillJoystickImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                .scaledToFit()
                        } else {
                            Image(newWeapon.weaponJoystickImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                .scaledToFit()
                        }
                        
                        
                        
                        HStack {
                            Button {
                                if isChoosingSkill {
                                    character.EquipedSkill = newSkill
                                } else {
                                    character.EquipedWeapon = newWeapon
                                }
                                
                            } label: {
                                ZStack(alignment: .center) {
                                    Image("button")
                                        .resizable()
                                        .frame(width: 140, height: 70)
                                        .scaledToFit()
                                        .padding(.leading, 10)
                                    
                                    Text("Equip")
                                        .font(.custom("AveriaSerifLibre-Regular", size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            }
                            
                            ZStack(alignment: .center) {
                                
                                Image("button")
                                    .resizable()
                                    .frame(width: 140, height: 70)
                                    .scaledToFit()
                                
                                HStack {
                                    
                                    Image(systemName: "arrowshape.up.fill")
                                        .resizable()
                                        .frame(width: 20, height: 40)
                                        .scaledToFit()
                                        .padding(.horizontal, 5)
                                    
                                    Text("100")
                                        .font(.custom("AveriaSerifLibre-Regular", size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Image("gold")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .scaledToFit()
                                    
                                }
                                
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

//#Preview {
//    SparksView()
//}
