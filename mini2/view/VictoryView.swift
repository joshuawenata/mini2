//
//  VictoryView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 20/06/24.
//

import SwiftUI

struct VictoryView: View {
    
    var items = Array(0...20)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bgLandingPage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Text("Victory")
                        .font(.custom("JollyLodger", size: 80))
                                .foregroundColor(.white)
                                .padding()
                                .frame(height: 50)
                                .padding(.bottom, 20)
                    Text("You got these items!")
                        .font(.custom("JollyLodger", size: 30))
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(items, id: \.self) { item in
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 5)
                            }
                        }
                    }
                    .frame(width: 330, height: 50)
                    
                    NavigationLink(destination: InGameView(), label: {
                        Image("continuebutton")
                            .resizable()
                            .frame(width: 250, height: 70)
                    })
                    .padding(.top, 20)
                }
            }
        }
    }
}

#Preview {
    VictoryView()
}
