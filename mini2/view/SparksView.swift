//
//  SparksView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 12/06/24.
//

import SwiftUI

struct SparksView: View {
    @Environment(\.presentationMode) var presentationMode
    let items = Array(0..<120)
    let itemsPerRow = 4
    
    var rows: Int {
        return (items.count + itemsPerRow - 1) / itemsPerRow
    }
    
    var body: some View {
        ZStack {
            Image("greenbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    NavigationLink(destination: CharacterView(), label: {
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
                    
                    NavigationLink(destination: InGameView(), label: {
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
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                                .padding(.horizontal)
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                        }
                        .padding(.vertical, 20)
                        
                        Spacer()
                        
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(0..<rows, id: \.self) { row in
                                    HStack(spacing: 20) {
                                        ForEach(0..<itemsPerRow, id: \.self) { column in
                                            let index = row * itemsPerRow + column
                                            if index < items.count {
                                                Rectangle()
                                                    .fill(Color.white)
                                                    .frame(width: 80, height: 80)
                                                    .cornerRadius(20)
                                                    .padding(.horizontal, 5)
                                                    .overlay(Text("\(index + 1)")) // To show the item number for clarity
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    VStack (alignment: .center) {
                        
                        HStack {
                            
                            Text("Crystal Sword")
                                .font(.custom("AveriaSerifLibre-Regular", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .frame(height: 50)
    
                            Image("dmg")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Text("+10")
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(height: 50)
                            
                        }
                        
                        Image("crystalSword")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                        
                        
                        HStack {
                            
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
                                        .padding(.horizontal, 5)
                                    
                                    Text("1000")
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

#Preview {
    SparksView()
}
