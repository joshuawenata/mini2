//
//  optionView.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 12/06/24.
//

import SwiftUI

struct optionView: View {
    var body: some View {
        ZStack {
            Image("bgDefault")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Continue Game")
                    .font(.custom("JollyLodger", size: 40))
                    .foregroundStyle(.white)
                Text("Settings")
                    .font(.custom("JollyLodger", size: 40))
                    .foregroundStyle(.white)
                    .padding(.top, 15)
                    .padding(.bottom, 20)
                Text("Exit Game")
                    .font(.custom("JollyLodger", size: 40))
                    .foregroundStyle(.white)
            }
        }
    }
}

