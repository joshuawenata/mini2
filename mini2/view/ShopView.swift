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
            weaponPrice: 200,
            weaponAttack: 15,
            weaponImage: "dagger"
        ),
        WeaponModel(
            weaponName: "Axe        ",
            weaponPrice: 300,
            weaponAttack: 25,
            weaponImage: "Axe"
        ),
    ]
    
    let skillList: [SkillModel] = [
        SkillModel(
            skillName: "Water    ",
            skillDamage: 20,
            skillCoolDown: 5,
            skillPrice: 300,
            skillImage: "water"
        ),
        SkillModel(
            skillName: "Pistol     ",
            skillDamage: 30,
            skillCoolDown: 5,
            skillPrice: 700,
            skillImage: "pistol"
        ),
        SkillModel(
            skillName: "Grenade",
            skillDamage: 50,
            skillCoolDown: 5,
            skillPrice: 900,
            skillImage: "grenade"
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
