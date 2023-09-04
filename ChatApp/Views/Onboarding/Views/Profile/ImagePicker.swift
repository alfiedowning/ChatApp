//
//  ImagePicker.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import Foundation
import UIKit
import SwiftUI


// This kind of builds the bridge between using classes from UIKit with SwiftUI

// This allows us to basically represent these classes as a SwiftUI view

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    
    @Binding var isPickerShowing: Bool
    
    var source:  UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = source
        // object that can receive UIImagePickerController events
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        
        // We use self so we can pass the instance of this method to the Coordinator class, so that the Coordinator class can have access to all the methods and propertieis in the ImagePicker class
        
        return Coordinator(self)
        
    }
    
}

// When defining the delegate, we use classes

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
 
        self.parent = picker
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Run code when user has selected an image
        
        print("image selected")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // We were able to get the image
            
            // This will be changing the UI, so we should be doing this in the main thread rather than the background thread
            
            DispatchQueue.main.async {
                
                self.parent.selectedImage = image

            }
            
        }
        
        // Dismiss the picker
        
        parent.isPickerShowing = false
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Run some code when the user has cancelled the picker UI
        print("cancelled")
        
        parent.isPickerShowing = false
        
    }
    
}
