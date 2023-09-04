//
//  ContactsViewModel.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    private var localContacts: [CNContact] = [CNContact]()
    
    private var users = [User]()
    
    private var filteredText = ""
    @Published var filteredUsers = [User]()
    
    
    func getLocalContacts() {
        // Ask for permission
        
        
        // Get contacts from user's phone
        
        
        // Get user's contacts asynchronously to prevent UI unresponsiveness
        DispatchQueue.init(label: "getContacts").async {
            do {
                
                let store = CNContactStore()
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as! [CNKeyDescriptor]
                
                let fetchReuqest = CNContactFetchRequest(keysToFetch: keys)
                
                try  store.enumerateContacts(with: fetchReuqest) { contact, success in
                    
                    
                    
                    // Do something with contact
                    
                    self.localContacts.append(contact)
                    
                    
                    
                }
                
                
                // See which local users are registred for app
                DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                    
                    
                    DispatchQueue.main.async { // Need to do in main thread since it updates the UI
                        // Now have registred users
                        
                            self.users = platformUsers
                        
                        
                        self.filterContacts(filterBy: self.filteredText)
                        
                                                
                        
                    }
                
                    
                }
                
                
            }
            
            catch {
                // Handle error
                
            }
        }
        
        
    }
    
    
    func filterContacts(filterBy: String) {
        
        self.filteredText = filterBy
        
        if filteredText == "" {
        
            self.filteredUsers = users
            
            return
        }
        
        self.filteredUsers = users.filter({ user in
            
            
            
            user.firstName?.lowercased().contains(filteredText) ?? false || user.lastName?.lowercased().contains(filteredText) ?? false || user.phone?.lowercased().contains(filteredText) ?? false
        })
        
        
    }
    
    func getParticipants(ids: [String]) -> [User] {
        
        
        // Filter users for the participants in chat from ids
        let foundUsers = users.filter { user in
            if user.id == nil {
                return false
            } else {
                return ids.contains(user.id!)

            }
        }
        
        return foundUsers
        
    }
    
    
}
