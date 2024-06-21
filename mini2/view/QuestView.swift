//
//  QuestView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 20/06/24.
//

import SwiftUI

struct QuestView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var quests = [
        Quest(id: 1, title: "Deliver items to the blacksmith", reward: 100, completed: false),
        Quest(id: 2, title: "Defeat the dragon", reward: 200, completed: false),
        Quest(id: 3, title: "Collect 10 apples", reward: 50, completed: false),
        Quest(id: 4, title: "Find the lost cat", reward: 150, completed: false),
        Quest(id: 5, title: "Help the old lady", reward: 75, completed: false),
    ]
    
    var body: some View {
        ZStack {
            Image("greenbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Quest")
                        .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
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
                    
                    ForEach(quests, id: \.id) { quest in
                        
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
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    ZStack{
                                        Image("bgcoin")
                                            .resizable()
                                            .frame(width: 120, height: 80)
                                            .scaledToFit()
                                        HStack {
                                            Text(String(quest.reward))
                                                .foregroundStyle(.white)
                                                .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                            Image("coin")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                    .padding(.trailing, 50)
                                    Text(quest.title)
                                        .foregroundStyle(.white)
                                        .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                        .padding(.trailing, 50)
                                        .frame(width: 500)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    
                }
                .padding(.horizontal, 30)
            }
        }
        .padding(.leading, 50)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    QuestView()
}
