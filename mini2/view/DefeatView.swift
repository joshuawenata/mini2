//
//  DefeatView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 20/06/24.
//

import SwiftUI

struct DefeatView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bgLandingPage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Text("Defeat")
                        .font(.custom("JollyLodger", size: 80))
                                .foregroundColor(.white)
                                .padding()
                                .frame(height: 50)
                                .padding(.bottom, 20)
                    
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
    DefeatView()
}
