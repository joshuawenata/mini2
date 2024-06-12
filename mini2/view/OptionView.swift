import SwiftUI

struct OptionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("bgDefault")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Continue Game")
                        .font(.custom("JollyLodger", size: 40))
                        .foregroundStyle(.white)
                })
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
        .navigationBarBackButtonHidden(true)
    }
}
