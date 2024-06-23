//
//  ShopView.swift
//  mini2
//
//  Created by Raphael on 12/06/24.
//

import SwiftUI

struct ShopView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let weaponList: [WeaponModel] = [
        WeaponModel(
            weaponName: "Dagger   ",
            weaponDescription: "Every knight needs a trusty steed, a shining suit of armor, and...a glorified letter opener? Don't underestimate the dagger, though! It's perfect for close calls, fancy finger flicking, and reminding everyone you're still dangerous even after you lose your sword in a particularly dramatic battle cry.",
            weaponPrice: 200,
            weaponAttack: 15,
            weaponImage: "dagger",
            weapomJoystickImage: "dagger_joystick"
        ),
        WeaponModel(
            weaponName: "Axe        ",
            weaponDescription: "Forget the lute, the real crowd-pleaser is a well-placed axe swing! Sure, it might not be the most melodic, but the rhythmic \"thunk\" of an axe burying itself in a foe's armor is guaranteed to get a head (or two) bobbing.",
            weaponPrice: 300,
            weaponAttack: 25,
            weaponImage: "Axe",
            weapomJoystickImage: "axe_joystick"
        ),
    ]
    
    let skillList: [SkillModel] = [
        SkillModel(
            skillName: "Water    ",
            skillDamage: 20,
            skillCoolDown: 5,
            skillPrice: 300,
            skillDescription: "Feel the power of the ocean (or at least a garden hose) with this refreshing (yet surprisingly forceful) water blast! Ideal for cooling down overheated enemies, or simply delivering a playful (but slightly embarrassing) surprise.",
            skillImage: "water",
            SkillJoystickImage: "water_joystick"
        ),
        SkillModel(
            skillName: "Pistol     ",
            skillDamage: 30,
            skillCoolDown: 5,
            skillPrice: 700,
            skillDescription: "A tool that converts money into noise very efficiently. Turns out, there's no better way to say \"I love spending money\" than launching tiny explosions out of a metal tube.",
            skillImage: "pistol",
            SkillJoystickImage: "pistol_joystick"
        ),
        SkillModel(
            skillName: "Grenade",
            skillDamage: 50,
            skillCoolDown: 5,
            skillPrice: 900,
            skillDescription: "A grenade? It's basically a one-way friendship bracelet. You pull the pin, toss it over, and yell \"Here comes a hug!\"  Except, instead of a hug, everyone gets a confetti explosion (made of shrapnel, not glitter, unfortunately). It's the ultimate party favor, guaranteed to liven things up... for a very short time.  Just remember, the only cool grenade throw is the one you never have to make.",
            skillImage: "grenade",
            SkillJoystickImage: "grenade_joystick"
        ),
    ]
    
    func itemWeaponRow(weapon: WeaponModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 600, height: 100)
                .foregroundColor(Color(red: 0.137, green: 0.43137254901960786, blue: 0.1607843137254902))
                .frame(maxHeight: 100)
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 550, height: 45)
                .foregroundColor(Color(red: 0.16862745098039217, green: 0.5411764705882353, blue: 0.19607843137254902))
                .frame(maxHeight: 100)
                .offset(y: -15)
            
            
            HStack {
                Image(weapon.weaponImage)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 140, maxHeight: 80)
                    .scaledToFill()
                    .cornerRadius(15)
                    .offset(x: -5)
                Text(weapon.weaponName)
                    .foregroundStyle(.white)
                    .font(.custom("AveriaSerifLibre-Regular", size: 40))
                    .padding(10)
                Image("sword")
                    .resizable()
                    .frame(maxWidth: 30, maxHeight: 30)
                    .padding(.leading)
                Text("+\(weapon.weaponAttack)")
                    .foregroundStyle(.white)
                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                Text("\(weapon.weaponPrice)")
                    .padding()
                    .foregroundStyle(.white)
                    .offset(x: 20)
                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                Image("coin")
                    .resizable()
                    .frame(maxWidth: 40, maxHeight: 40)
            }
        }
    }
    
    func itemSkillRow(skill: SkillModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 600, height: 100)
                .foregroundColor(Color(red: 0.137, green: 0.43137254901960786, blue: 0.1607843137254902))
                .frame(maxHeight: 100)
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 550, height: 45)
                .foregroundColor(Color(red: 0.16862745098039217, green: 0.5411764705882353, blue: 0.19607843137254902))
                .frame(maxHeight: 100)
                .offset(y: -15)
            
            
            HStack {
                Image(skill.skillImage)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 140, maxHeight: 80)
                    .scaledToFill()
                    .cornerRadius(15)
                    .offset(x: -5)
                Text(skill.skillName)
                    .foregroundStyle(.white)
                    .font(.custom("AveriaSerifLibre-Regular", size: 40))
                    .padding(10)
                Image("sword")
                    .resizable()
                    .frame(maxWidth: 30, maxHeight: 30)
                    .padding(.leading)
                Text("+\(skill.skillDamage)")
                    .foregroundStyle(.white)
                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                Text("\(skill.skillPrice)")
                    .padding()
                    .foregroundStyle(.white)
                    .offset(x: 20)
                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                Image("coin")
                    .resizable()
                    .frame(maxWidth: 40, maxHeight: 40)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Image("greenbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Shop")
                        .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaledToFit()
                        .padding()
                    Spacer()
                    
                    Text("999999")
                        .padding()
                        .foregroundStyle(.white)
                        .offset(x: 20)
                        .font(.custom("AveriaSerifLibre-Regular", size: 30))
                    Image("coin")
                        .resizable()
                        .frame(maxWidth: 40, maxHeight: 40)
                    

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("cancel")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFit()
                            .padding(.horizontal, 20)
                            .scaledToFit()

                    }
                }
                .padding(15)
                .padding(.horizontal, 30)
                
                Spacer()
                
                ScrollView {
                    ForEach(weaponList) { weapon in
                        itemWeaponRow(weapon: weapon)
                    }
                    ForEach(skillList) { skill in
                        itemSkillRow(skill: skill)
                    }
                }
                .scrollIndicators(.never)
                .padding(.horizontal, 60)
            }
            .padding(.horizontal, 20)
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ShopView()
}
