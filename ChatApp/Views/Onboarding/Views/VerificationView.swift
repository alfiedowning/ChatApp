//
//  VerificationView.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import SwiftUI

struct VerificationView: View {
    @Binding var currentStep: OnBoardingStep
    @Binding var isOnboarding: Bool
    @State var code: String = ""
    var body: some View {
        
        let codeEntered = Binding(get: { self.code}, set: {self.code = String($0.prefix(6))})

        VStack(spacing:20) {
            
            Text("Verification")
                .font(.majorHeading)
            
            Text("Enter the 6-digit verification code below.")
                .font(.bodyText)
            
        
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .frame(height:56)
                    
                    HStack {
                        
                        
                        TextField("e.g. 123456", text: codeEntered)
                            .keyboardType(.numberPad)
                        
                        Spacer()
                        
                        Button {
                            code = ""
                            
                        } label: {
                            
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.secondary.opacity(0.7))
                        }
                        
                        
                    }
                    .padding(.all,20)
                }
                .padding(.all,20)

                
                

               
                
     
            Spacer()
            
            Button {
                
                // Need to check if code matches
                AuthViewModel.verifyCode(code: code) { error  in
                    if error == nil {
                        
                        // Check if user has a profile
                        
                        DatabaseService().checkIfUserExists { userExists in
                            if userExists {
                                // End onboarding
                                isOnboarding = false
                            } else {
                                currentStep = .profile
                            }
                        }
                        
                        
                        
                
                    } else {


                    }
                    
                    
                }
                
                
                
            } label: {
                CustomButton(text: "Confrim")
            }

            
            
        }
        .padding(.horizontal)
        .padding(.top,40)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verifcation), isOnboarding: .constant(true))
    }
}
