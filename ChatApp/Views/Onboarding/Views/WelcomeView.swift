//
//  WelcomeView.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var currentStep: OnBoardingStep
    var body: some View {
        
        VStack{
            
            Spacer()
            
            VStack(spacing:20) {
                Logo()
                
                Text("Welcome to Chat")
                    .font(.majorHeading)
                
                Text("A simple way to connect with friends and family.")
                    .font(.bodyText)
            }
            
            Spacer()
            
            
            
            
            
            
            Button {
                currentStep = .phoneNumber
            } label: {
                
                CustomButton(text: "Get Started")
                
            }
                
            Text("By tapping 'Get Started', you agree to our Privacy Policy")
                .font(.italic)
                .padding(.bottom,10)
            
            
            
            
            
            
            
        }
        .padding(.horizontal)
        
        
        
        
        
    }
}





struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(currentStep: .constant(.welcome))
    }
}


