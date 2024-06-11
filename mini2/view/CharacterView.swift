//
//  CharacterView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 10/06/24.
//

import SwiftUI

struct CharacterView: View {
    var body: some View {
        ZStack {
            Image("bgDefault")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Character")
                        .font(.custom("JollyLodger", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaledToFit()
                    Text("Sparks")
                        .font(.custom("JollyLodger", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .opacity(0.5)
                        .scaledToFit()
                    Spacer()
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 15)
                
                Spacer()
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Status")
                            .font(.custom("JollyLodger", size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(height: 50)
                        
                        HStack {
                            HStack {
                                Image("dmg")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("5")
                                    .font(.custom("JollyLodger", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                Text("100")
                                    .font(.custom("JollyLodger", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        
                        Text("Clothing")
                            .font(.custom("JollyLodger", size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        Image("clothing")
                            .resizable()
                            .frame(width: 250, height: 50)
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                    }
                    
                    VStack {
                        
                        Image("charaIdle")
                            .resizable()
                            .frame(width: 150, height: 200)
                            .padding(.horizontal, 150)
                        
                        Text("Naruto")
                            .font(.custom("JollyLodger", size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(height: 50)
                        
                    }
                    
                }
                    
            }
            .padding(.horizontal, 50)
            
        }
    }
}

#Preview {
    CharacterView()
}
