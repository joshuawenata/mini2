//
//  FoundView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 23/06/24.
//

import SwiftUI

struct FoundView: View {
    
    @StateObject private var audioManager = AudioManager()
    @State private var audioFiles: [URL] = []
    
    var items = Array(0...9)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bgDefault")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HStack {
                    VStack {
                        Text("You Found Something!")
                            .font(.custom("AveriaSerifLibre-Regular", size: 50))
                            .foregroundColor(.white)
                            .padding()
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
                        .padding(.vertical, 20)
                        
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FoundView()
}
