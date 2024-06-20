//
//  DefeatView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 20/06/24.
//

import SwiftUI

struct DefeatView: View {
    
    var items = Array(0...9)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("defeatbg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    VStack {
                        Text("You lost")
                            .font(.custom("AveriaSerifLibre-Regular", size: 50))
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .padding(.bottom, 20)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(items, id: \.self) { item in
                                    Rectangle()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                        .frame(width: 260, height: 50)
                        .padding(20)
                        
                        NavigationLink(destination: InGameView(), label: {
                            ZStack {
                                Image("button")
                                    .resizable()
                                    .frame(width: 200, height: 70)
                                Text("Finish")
                                    .font(.custom("AveriaSerifLibre-Regular", size: 30))
                                    .foregroundColor(.white)
                            }
                        })
                        .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 20)
                
            }
        }
    }
}

#Preview {
    DefeatView()
}
