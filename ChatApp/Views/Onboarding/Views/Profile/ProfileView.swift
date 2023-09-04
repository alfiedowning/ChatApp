//
//  ProfileView.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @Binding var currentStep: OnBoardingStep
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType
    @State var isSaveButtonDisabled = false
    var body: some View {
        VStack(spacing:45) {
            
            VStack(spacing:20) {
                Text("Setup Profile")
                    .font(.majorHeading)
                
                Text("Just a few more details then you're good to go.")
                    .font(.bodyText)
                
            }
                            
                
                Button {
                    
                    
                    
                        
                        isSourceMenuShowing = true
                        
          

                    
                } label: {
                    
                    
                    if selectedImage == nil {
                        ZStack {
                            
                            Circle()
                                .foregroundColor(.secondary.opacity(0.2))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "camera.fill")
                            
                        }
                        .foregroundColor(.black)
                        
                    } else {
                        
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)

                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                
            VStack(spacing:25) {
                
                
                
                TextEntryField(placeHolderText: "First Name", text: $firstName)
                
                TextEntryField(placeHolderText: "Last Name", text: $lastName)
                
                
                
                
                
                
                Spacer()
                
                    Button {
                        
                        //TODO: Check if first and last name entered
                        
                        isSaveButtonDisabled = true
                            
                        DatabaseService().setUserProfile(firstName: firstName, lastName: lastName, image: selectedImage) { uploadedSuccessfully in
                                
                                print(uploadedSuccessfully)
                                
                                if uploadedSuccessfully {
                                    
                                    currentStep = .contacts
                                    
                                    
                                } else {
                                    
                                    
                                    // TODO: Show error message
                                    
                                    
                                }
                                
                                isSaveButtonDisabled = false
                                
                                
            
                        }
                        
                        
                        
                        
                    } label: {
                        CustomButton(text: !isSaveButtonDisabled ? "Complete Profile" : "Uploading")
                    }
                    .disabled(isSaveButtonDisabled)
                    
                
                
            }
            
            
            
            
        }
        .padding(.horizontal)
        .padding(.top,40)
        
        .sheet(isPresented: $isPickerShowing) {
            // Show the image picker
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: source)
        }
        
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing) {
            Button {
                source = .photoLibrary
                isPickerShowing = true
            } label: {
                Text("Photo Lbrary")
            }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                
                Button {
                    source = .camera
                    isPickerShowing = true
                } label: {
                    Text("Take photo")
                }
                
            }
            
            
        }
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(currentStep: .constant(.profile), source: .photoLibrary)
    }
}

struct TextEntryField: View {
    var placeHolderText: String
    @Binding var text: String
    var showEmptyButton: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .frame(height:56)
            
            HStack {
                TextField(placeHolderText, text: $text)
                    .font(.bodyText)
                
                Spacer()
                
                if showEmptyButton {
                    Button {
                        text = ""
                        
                    } label: {
                        
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.secondary.opacity(0.7))
                    }
                    
                }
                
            }
            .padding(.horizontal,20)
        }
        .padding(.horizontal,20)
    }
}
