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
            Image("greenbg1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Leaderboard")
                        .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaledToFit()
                        .padding()
                    Text("winrate%")
                        .font(.custom("AveriaSerifLibre-Regular", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .opacity(0.6)
                        .scaledToFit()
                        .padding()
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
                .padding(.horizontal, 30)
                
                Spacer()
                
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 700, height: 100)
                            .foregroundColor(Color(red: 0.137, green: 0.43137254901960786, blue: 0.1607843137254902))
                            .frame(maxHeight: 100)
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 650, height: 45)
                            .foregroundColor(Color(red: 0.16862745098039217, green: 0.5411764705882353, blue: 0.19607843137254902))
                            .frame(maxHeight: 100)
                            .offset(y: -15)
                        
                        
                        HStack {
                            Text("#1")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 50))
                                .offset(x: -70)
                            Image("profileicon")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 80, maxHeight: 80)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -5)
                            Text("|||Exalted|||")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                .padding(.trailing, 50)
                            Text("100%")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        }
                    }
                    .padding(.bottom, -10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 700, height: 100)
                            .foregroundColor(Color(red: 0.137, green: 0.43137254901960786, blue: 0.1607843137254902))
                            .frame(maxHeight: 100)
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 650, height: 45)
                            .foregroundColor(Color(red: 0.16862745098039217, green: 0.5411764705882353, blue: 0.19607843137254902))
                            .frame(maxHeight: 100)
                            .offset(y: -15)
                        
                        
                        HStack {
                            Text("#1")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 50))
                                .offset(x: -70)
                            Image("profileicon")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 80, maxHeight: 80)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -5)
                            Text("|||Exalted|||")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                .padding(.trailing, 50)
                            Text("100%")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        }
                    }
                    .padding(.bottom, -10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 700, height: 100)
                            .foregroundColor(Color(red: 0.137, green: 0.43137254901960786, blue: 0.1607843137254902))
                            .frame(maxHeight: 100)
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 650, height: 45)
                            .foregroundColor(Color(red: 0.16862745098039217, green: 0.5411764705882353, blue: 0.19607843137254902))
                            .frame(maxHeight: 100)
                            .offset(y: -15)
                        
                        
                        HStack {
                            Text("#1")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 50))
                                .offset(x: -70)
                            Image("profileicon")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 80, maxHeight: 80)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -5)
                            Text("|||Exalted|||")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                .padding(.trailing, 50)
                            Text("100%")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        }
                        
                    }
                }
                .padding(.horizontal, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LeaderboardView()
}
