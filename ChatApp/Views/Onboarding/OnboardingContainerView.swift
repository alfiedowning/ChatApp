//
//  OnboardingContainerView.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import SwiftUI

enum OnBoardingStep: Int {
    case welcome = 0
    case phoneNumber = 1
    case verifcation = 2
    case profile = 3
    case contacts = 4
}

struct OnboardingContainerView: View {
    @State var currentStep: OnBoardingStep = .welcome
    @EnvironmentObject var model: ContactsViewModel
    @Binding var isOnboarding: Bool
    var body: some View {
        
        
        ZStack {
            
            Color(.gray).opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            
            switch currentStep {
            case .welcome:
                WelcomeView(currentStep: $currentStep)
            case .phoneNumber:
                PhoneView(currentStep: $currentStep)
            case .verifcation:
                VerificationView(currentStep: $currentStep, isOnboarding: $isOnboarding)
            case .profile:
                ProfileView(currentStep: $currentStep, source: .photoLibrary)
                
            case .contacts:
                SyncContactsView(currentStep: $currentStep, isOnboarding: $isOnboarding)
                
            }
            
            
            
            
        }
        
        
        
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView(isOnboarding: .constant(true))
            .environmentObject(ContactsViewModel())
    }
}
