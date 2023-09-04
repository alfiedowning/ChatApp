//
//  SyncContactsView.swift
//  ChatApp
//
//  Created by Alfie Downing on 22/08/2023.
//

import SwiftUI

struct SyncContactsView: View {
    @EnvironmentObject var model: ContactsViewModel
    @Binding var currentStep: OnBoardingStep
    @Binding var isOnboarding: Bool
    var body: some View {
        
        VStack{
            
            Spacer()
            
            VStack(spacing:20) {
                Logo()
                
                Text("You're all good to go")
                    .font(.majorHeading)
                
                Text("Start chatting with friends and family")
                    .font(.bodyText)
            }
            
            Spacer()
            
            
            
            
            
            
            Button {
                isOnboarding = false
            } label: {
                
                CustomButton(text: "Continue")
                
            }
            
            
        }
        .padding(.horizontal)
        .onAppear {
            model.getLocalContacts()
           
        }
        
        
        
        
    }
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactsView(currentStep: .constant(.contacts), isOnboarding: .constant(true))
            .environmentObject(ContactsViewModel())
    }
}
