//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Alfie Downing on 22/08/2023.
//

import Foundation
import FirebaseStorage
import Firebase
import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var chats = [Chat]()
    @Published var selectedChat: Chat?
    @Published var messages = [ChatMessage]()
    
    var databaseService = DatabaseService()
    
    init() {
        getChats()
    }
    
    func getChats() {
    
        // Retreive the chats
        databaseService.getAllChats { chats in
            
//            self.chats = chats.sorted(by: { chat1, chat2 in
//                chat1.updated ?? Date() > chat2.updated ?? Date()
//            })
            
            self.chats = chats
            self.chats = self.chats.sorted(by: { chat1, chat2 in
                chat1 .updated ?? Date() > chat2.updated ?? Date()
            })
        }
        
    }
    
    func getMessages() {
        
        if selectedChat != nil {
            
            databaseService.getMessages(chat: selectedChat!) { messages in
                self.messages = messages
            }
        }
    }
    
    func sendMessage(message: String) {
        
        // Check have selected chat
        
        guard selectedChat != nil else {
            return
        }
        
        databaseService.sendMessage(msg: message, chat: selectedChat!) {
            self.chats = self.chats.sorted(by: { chat1, chat2 in
                return chat1.updated ?? Date() > chat2.updated ?? Date()
            })
        }

        
        
        
        
    }
    
    
    /// Remove current user from array of ids
    func getParticipantIDs() -> [String] {
        
        guard selectedChat != nil else {
            return [String]()
        }
        
        let ids = selectedChat!.participantIDs.filter({ id in
            id != AuthViewModel.getLoggedInUserID()
        })
        
        return ids
        
    }
    
    /// Search for chat with selected user if not found, create a new chat
    func getChatFor(contact: User) {
        
        guard contact.id != nil else {
            return
        }
        
        
        let foundChat = chats.filter { chat in
            return chat.numParticipants == 2 && chat.participantIDs.contains([AuthViewModel.getLoggedInUserID(), contact.id!]) // TODO: Remove current user's id?
            
            
        }
        
        if !foundChat.isEmpty {
            selectedChat = foundChat.first!
            getMessages()
        } else {
            // No chat found, create a new one
            
            var newChat = Chat(id: nil, lastMessage:nil, numParticipants: 2, participantIDs: [AuthViewModel.getLoggedInUserID(), contact.id!], msgs: nil)
            self.selectedChat = newChat

            databaseService.createChat(chat: newChat, completion: { docID in
                
                self.selectedChat = Chat(id: docID, lastMessage:nil, numParticipants: 2, participantIDs: [AuthViewModel.getLoggedInUserID(), contact.id!], msgs: nil)
                self.chats.append(self.selectedChat!)

            })
        }
        
        
    }
    
    
    func closeConversationViewListeners() {
        databaseService.detatchConversationViewListeners()
    }
    
    func closeChatListViewListeners() {
        databaseService.detatchChatListViewListeners()
    }
    
    
}
