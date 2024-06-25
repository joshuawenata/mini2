//
//  BackpackView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 11/06/24.
//

import SwiftUI

struct BackpackView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var audioManager = AudioManager()
    @State private var audioFiles: [URL] = []
    
    let items = Array(0..<120)
    let itemsPerRow = 6

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
                    Text("Backpack")
                        .font(.custom("AveriaSerifLibre-Regular", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaledToFit()
                        .padding()
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        if let url = Bundle.main.url(forResource: "exit", withExtension: "wav") {
                            audioManager.loadAudioFiles(urls: [url])
                            audioManager.play()
                        }
                    }) {
                        Image("cancel")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFit()
                            .padding(.horizontal, 20)
                            .scaledToFit()
                    }
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 15)
                
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
                                            .padding(.horizontal, 10)
                                            .overlay(Text("\(index + 1)")) // To show the item number for clarity
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .padding(.horizontal, 50)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BackpackView()
}
