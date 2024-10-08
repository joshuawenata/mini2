//
//  QuestView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 20/06/24.
//

import SwiftUI
import SwiftData

struct QuestView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @Query(sort: \Quest.id) var quests: [Quest]
    
    @StateObject private var audioManager = AudioManager()
    @State private var audioFiles: [URL] = []
    
    var body: some View {
        ZStack {
            Image("greenbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Quest")
                        .font(.custom("AveriaSerifLibre-Regular", size: 35))
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
                .padding(15)
                .padding(.horizontal, 30)
                
                Spacer()
                
                ScrollView {
                    
                    ForEach(quests, id: \.id) { quest in
                        
                        if !quest.completed {
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
                    
                }
                .padding(.horizontal, 30)
            }
        }
        .padding(.leading, 50)
        .navigationBarBackButtonHidden(true)
    }
}

struct QuestView_Previews: PreviewProvider {
    struct QuestViewPreviewWrapper: View {
        @State private var character = Character()

        var body: some View {
            QuestView()
        }
    }

    static var previews: some View {
        QuestViewPreviewWrapper()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
