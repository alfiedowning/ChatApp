//
//  Chat.swift
//  ChatApp
//
//  Created by Alfie Downing on 22/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable {
    @DocumentID var id: String? // ID not an attribute in database
    
    var lastMessage: String?
    
    @ServerTimestamp var updated: Date? // Convert from firebase specific timestamp data type
    
    var numParticipants: Int
    
    var participantIDs: [String]
    
    var msgs: [ChatMessage]?
    
}


struct ChatMessage: Codable, Identifiable, Hashable {
    
    @DocumentID var id: String?
    
    var imageURL: String?
    
    var msg: String
    
    @ServerTimestamp var timestamp: Date?
    
    var senderID: String
    
}
