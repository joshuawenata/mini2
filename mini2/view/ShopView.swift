//
//  ShopView.swift
//  mini2
//
//  Created by Raphael on 12/06/24.
//

import SwiftUI

struct ShopView: View {
    @Environment(\.presentationMode) var presentationMode
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
                            Image("fireball")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 140, maxHeight: 80)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -5)
                            Text("Fireball")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 40))
                                .padding(10)
                            Image("sword")
                                .resizable()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .padding(.leading)
                            Text("+10")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            //                        .padding(.trailing, 50)
                            Text("100")
                                .padding()
                                .foregroundStyle(.white)
                                .offset(x: 20)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            Image("coin")
                                .resizable()
                                .frame(maxWidth: 40, maxHeight: 40)
                        }
                        //                .padding(.horizontal, 10.0)
                    }
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
                            Image("fireball")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 140, maxHeight: 80)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -5)
                            Text("Fireball")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 40))
                                .padding(10)
                            Image("sword")
                                .resizable()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .padding(.leading)
                            Text("+10")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            //                        .padding(.trailing, 50)
                            Text("100")
                                .padding()
                                .foregroundStyle(.white)
                                .offset(x: 20)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            Image("coin")
                                .resizable()
                                .frame(maxWidth: 40, maxHeight: 40)
                        }
                        //                .padding(.horizontal, 10.0)
                    }
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
                            Image("fireball")
                                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 140, maxHeight: 80)
                                .scaledToFill()
                                .cornerRadius(15)
                                .offset(x: -5)
                            Text("Fireball")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 40))
                                .padding(10)
                            Image("sword")
                                .resizable()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .padding(.leading)
                            Text("+10")
                                .foregroundStyle(.white)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            //                        .padding(.trailing, 50)
                            Text("100")
                                .padding()
                                .foregroundStyle(.white)
                                .offset(x: 20)
                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                            Image("coin")
                                .resizable()
                                .frame(maxWidth: 40, maxHeight: 40)
                        }
                        //                .padding(.horizontal, 10.0)
                    }
                }
                .padding(.horizontal, 60)
            }
            .padding(.horizontal, 20)
            
            
        }
        
    }
}

#Preview {
    ShopView()
}
