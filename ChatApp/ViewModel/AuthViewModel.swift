//
//  AuthViewModel.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
    
    
    static func isUserLoggedIn() -> Bool {
        
        
//        try? Auth.auth().signOut()
        
        return Auth.auth().currentUser != nil
        
    }
    
    static func getLoggedInUserID() -> String {
        
        return Auth.auth().currentUser?.uid ?? ""
        
    }
    
    static func getLoggedInUserPhone() -> String {
        return Auth.auth().currentUser?.phoneNumber ?? ""
    }
    
    
    static func logOut() {
        try? Auth.auth().signOut()
        
    }
    
    static func sendPhoneNumber(phoneNumber: String, completion: @escaping (Error?) -> Void) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            
            if error == nil {
                
                // Have the verifcationID
                
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                
               
            }
            
            DispatchQueue.main.async {
                // Notify UI in main thread
                completion(error) // Will be nil if no error has occurred

            }
            
            
            
        }
        
    }
    
    static func verifyCode(code: String, completion: @escaping (Error?) -> Void) {
        
        // Get verification ID from local storage
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        
        
        // Send the code and the verification ID to Firebase
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        // Sign in the user
        Auth.auth().signIn(with: credential) { authResult, error in
            
            DispatchQueue.main.async {
                // Notify UI in main thread
                completion(error)
            }
          
            
            
        }
        
        
        
    }
    
    
}
