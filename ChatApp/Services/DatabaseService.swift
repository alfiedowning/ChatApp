//
//  DatabaseService.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import Foundation
import Contacts
import Firebase
import FirebaseStorage
import FirebaseFirestore

class DatabaseService {
    
    var chatListViewListeners = [ListenerRegistration]()
    var conversationViewListeners = [ListenerRegistration]()
    
     func getPlatformUsers(localContacts: [CNContact], completion: @escaping ([User]) -> Void) {
        
        var platformUsers = [User]()
        
        // Create array of phone numbers to lookup
        var lookupPhoneNumbers = localContacts.map { contact in
            // Transform contact to phone number
            return TextHelper.santisePhoneNumber(phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "")
        }
        
        
        // Check to see if lookup phone numbers
        
        guard lookupPhoneNumbers.count > 0 else {
            completion(platformUsers)
            return
        }
        
        // Query database for phone numbers
        let db = Firestore.firestore()
        
        // Get the first 10 or less phone numbers
        
        
        while !lookupPhoneNumbers.isEmpty {
            let firstTenNumbers = Array(lookupPhoneNumbers.prefix(10))
            lookupPhoneNumbers = Array(lookupPhoneNumbers.dropFirst(10))
            let query = db.collection("users").whereField("phone", in: firstTenNumbers)
            query.getDocuments { snapshot, error in
                if error == nil && snapshot != nil {
                    
                    for doc in snapshot!.documents {
                        
                        // Create users
                        if let user = try? doc.data(as: User.self) {
                            // Append user to platform users array
                            
                            platformUsers.append(user)
                            
                            
                            
                        }
                        
                    }
                    
                    if lookupPhoneNumbers.isEmpty {
                        completion(platformUsers)
                        return
                    
                    }
                    
                }
            
            }
            
        }
        

        
    }
    
    func setUserProfile(firstName: String, lastName: String, image: UIImage?, completion: @escaping (Bool) -> Void) {
        
        // TODO: Guard against logged out users
        
        // Ensure that user is logged
        
        guard AuthViewModel.isUserLoggedIn() != false else {
            // User is not logged in
            return 
        }
        
        
        // Get reference to Firestore
        let db = Firestore.firestore()
        
        // Set profile data
        // TODO: After implementing authentication creare document with actual ID
        let doc = db.collection("users").document(AuthViewModel.getLoggedInUserID()) // Create a document that matches the UID in the autehntcated database
        doc.setData(["firstName": firstName,
                     "lastName" : lastName,
                     "phone": TextHelper.santisePhoneNumber(phoneNumber: AuthViewModel.getLoggedInUserPhone())])
        
        if let image = image {
            
            // Firebase storage reference
            let storage = Storage.storage().reference()
            
            // Specify image path
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storage.child(path)
            
            
            // Get image data
            let imageData = image.jpegData(compressionQuality: 0.8)
            
            guard imageData != nil else {
                return
            }
            
            
            let uploadTask = fileRef.putData(imageData!) { meta, error in // Uploads photo data to image collection in firestore
                
               
                if error == nil && meta != nil {
                    
                   // Set image path to the profile
                    
                
                    // Get full URL to image
                    fileRef.downloadURL { url, error in
                        
                        
                        if error == nil && url != nil {
                            
                            doc.setData(["photo" : url!.absoluteString], merge: true) { error in // Need to merge otherwise would overwrite data
                                
                                if error == nil {
                                    // Success notify caller
                                    
                                    completion(true)
                                    
                                } else {
                                    
                                }
                                     
                                
                                
                            }
                            
                        } else {
                            // Was not able to fetch profile image URL
                            completion(false)
                        }
                        
                        
                    }
                    

                    
                    
                } else {
                    // Upload not successful
                    completion(false)

                }
                
                
            }
            
            
            
        } else {
            completion(true)
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    func checkIfUserExists(completion: @escaping (Bool) -> Void){
        
        
        guard AuthViewModel.isUserLoggedIn() != false else {
            return
        }
        
        let db = Firestore.firestore()
        var userExists = true
        let docRef = db.collection("users").document(AuthViewModel.getLoggedInUserID())
        
        docRef.getDocument { snapshot, error in
            
            // TODO: keep the profile data
            
            if snapshot != nil && error == nil {
                completion(snapshot!.exists)
            } else {
                
                // TODO: look into using result type to indicate failure versus profile exists

                completion(false)
            }
            
        }
        
        
        
    }
    
    
    // MARK: - Chat methods
    
    /// This method returns all chat documents where the logged in user is a participant
    ///
    func getAllChats(completion: @escaping ([Chat]) -> Void) {
        
        
        // Get reference to database
        let db = Firestore.firestore()
        
        // Query the database for the chats that the logged in user is a participant
        let query = db.collection("chats").whereField("participantIDs", arrayContains: AuthViewModel.getLoggedInUserID())
        
        
        
        // Allow for real time updates
        let listener = query.addSnapshotListener { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                var chats = [Chat]()
                
                for chatDoc in snapshot!.documents {
                    
                    // Parse the returned data
                    let chat = try? chatDoc.data(as: Chat.self)
                    
                    if chat != nil {
                        chats.append(chat!)
                        
                    }
                }
                
                // Return the chats
                completion(chats)
                
                
            
                
            } else {
                
                print(error?.localizedDescription ?? "")
                
                
            }
        }
        
        // Keep track of listeners
        
        chatListViewListeners.append(listener)
            
    }
    
    
    func getMessages(chat: Chat, completion: @escaping (([ChatMessage]) -> Void)) {
        
        
        // Check that id is not nill
        
        guard chat.id != nil  else {
            // Can't fetch the data
            completion([ChatMessage]())
            return
        }
        
        
        let db = Firestore.firestore()
        
        let query = db.collection("chats").document(chat.id!)
            .collection("msgs")
            .order(by: "timestamp")
        
        // Allow for real time updates
        let listener = query.addSnapshotListener { snapshot, error in
                        
            if snapshot != nil && error == nil {
                
                var msgs = [ChatMessage]()

                
                for doc in snapshot!.documents {
                    
                    let message = try? doc.data(as: ChatMessage.self)
                    
                    if message != nil {
                        
                        msgs.append(message!)
                        
                        
                    }
                }
                
                
                completion(msgs)
                
                
            } else {
                
                print(error?.localizedDescription ?? "")
                
                
                
                
            }
            
            
        }
        // Keep track of listeners
        conversationViewListeners.append(listener)
        
    }
    
    func sendMessage(msg: String, chat: Chat, completion: @escaping (() -> Void)) {
        
        
        // Check chat id
        
        guard chat.id != nil else {
            return
        }
        
        // Reference to database
        let db = Firestore.firestore()
        
        
        let fileRef = db.collection("chats").document(chat.id!)
        
        
        // Update last message
        
        db.collection("chats").document(chat.id!).setData(["updated":Date(), "lastMessage": msg], merge: true)
        
        
        
        // Add message to database
        fileRef.collection("msgs").addDocument(data: ["imageURL" : "",
                                                      "msg": msg,
                                                      "senderID":AuthViewModel.getLoggedInUserID(),
                                                      "timestamp":Date()])
        
        
        
        
    }
    
    
    func createChat(chat: Chat, completion: @escaping (String) -> Void) {
        
        let db = Firestore.firestore()
        
        
        
        
        let doc = db.collection("chats").document()
        
        try? doc.setData(from: chat, completion: { error in
            if error == nil {
                
                
                completion(doc.documentID)
                
                
                
                
            }
        })
        
        
        
        
        
    }
    
    
    func detatchChatListViewListeners() {
        for listener in chatListViewListeners {
            listener.remove()
        }
    }
    
    func detatchConversationViewListeners() {
        for listener in conversationViewListeners {
            listener.remove()
        }
    }
    
}
