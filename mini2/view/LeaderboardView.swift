//
//  LeaderboardView.swift
//  mini2
//
//  Created by Raphael on 12/06/24.
//

import SwiftUI

struct LeaderboardView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image("greenbg 1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    HStack(alignment: .bottom){
                        Text("Leaderboard")
                            .font(.custom("AveriaSerifLibre-Regular", size: 35))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .scaledToFit()
                            .padding()
                        Text("winrate%")
                            .font(.custom("AveriaSerifLibre-Regular", size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .opacity(0.6)
                            .scaledToFit()
                            .padding()
                            .padding(.bottom, 2)
                    }
                    Spacer()
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
                .padding(.bottom, 15)
                .padding(.horizontal, 30)
                
                Spacer()
                
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 700, height: 100)
                            .foregroundColor(Color(red: 0.137, green: 0.43137254901960786, blue: 0.1607843137254902))
                            .frame(maxHeight: 100)
                            .shadow(radius: 2, y: 2)
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 650, height: 45)
                            .foregroundColor(Color(red: 0.16862745098039217, green: 0.5411764705882353, blue: 0.19607843137254902))
                            .frame(maxHeight: 100)
                            .offset(y: -15)
                        
                        
                        HStack {
                            Text("#1")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 45))
                                .offset(x: -120)
                            Image("profileicon")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 75, maxHeight: 75)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -100)
                            Text("|||Exalted|||")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 25))
                                .offset(x: -80)
                            Text("100%")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 35))
                                .offset(x: 120)
                        }
                    }
                    .padding(.bottom, -2)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 700, height: 100)
                            .foregroundColor(Color(red: 0.137, green: 0.43137254901960786, blue: 0.1607843137254902))
                            .frame(maxHeight: 100)
                            .shadow(radius: 2, y: 2)
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 650, height: 45)
                            .foregroundColor(Color(red: 0.16862745098039217, green: 0.5411764705882353, blue: 0.19607843137254902))
                            .frame(maxHeight: 100)
                            .offset(y: -15)
                        
                        
                        HStack {
                            Text("#1")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 45))
                                .offset(x: -120)
                            Image("profileicon")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 75, maxHeight: 75)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -100)
                            Text("|||Exalted|||")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 25))
                                .offset(x: -80)
                            Text("100%")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 35))
                                .offset(x: 120)
                        }
                    }
                    .padding(.bottom, -2)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 700, height: 100)
                            .foregroundColor(Color(red: 0.137, green: 0.43137254901960786, blue: 0.1607843137254902))
                            .frame(maxHeight: 100)
                            .shadow(radius: 2, y: 2)
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 650, height: 45)
                            .foregroundColor(Color(red: 0.16862745098039217, green: 0.5411764705882353, blue: 0.19607843137254902))
                            .frame(maxHeight: 100)
                            .offset(y: -15)
                        
                        
                        HStack {
                            Text("#1")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 45))
                                .offset(x: -120)
                            Image("profileicon")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 75, maxHeight: 75)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -100)
                            Text("|||Exalted|||")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 25))
                                .offset(x: -80)
                            Text("100%")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 35))
                                .offset(x: 120)
                        }
                        
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding(.leading, 40)
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    LeaderboardView()
//}
