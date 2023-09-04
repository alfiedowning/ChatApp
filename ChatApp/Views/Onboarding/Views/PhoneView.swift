//
//  PhoneView.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import SwiftUI

struct PhoneView: View {
    @Binding var currentStep: OnBoardingStep
    @State var number: String = ""
    var body: some View {
        VStack(spacing:20) {
            
            Text("Setup Profile")
                .font(.majorHeading)
            
            Text("Enter your mobile number. We'll send you a verifcation code after.")
                .font(.bodyText)
            
        
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .frame(height:56)
                    
                    HStack {
                        TextField("e.g. +44 7132 142071", text: $number)
                            .keyboardType(.phonePad)
                        
                        Spacer()
                        
                        Button {
                            number = ""
                            
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
                
                // Send phone number to firebase
                AuthViewModel.sendPhoneNumber(phoneNumber: number) { error in
                    if error != nil {
                    
                    } else {
                        currentStep = .verifcation
                        
                    }

                }
                
            } label: {
                CustomButton(text: "Verify")
            }

            
            
        }
        .padding(.horizontal)
        .padding(.top,40)
    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneView(currentStep: .constant(.phoneNumber))
    }
}
