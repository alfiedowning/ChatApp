//
//  ChatRow.swift
//  ChatApp
//
//  Created by Alfie Downing on 24/08/2023.
//

import SwiftUI

struct ChatRow: View {
    var otherParticipants: [User]?
    
    var chat: Chat
    
    var body: some View {
        
        if let otherParticipants = otherParticipants {
            
            let otherParticipant = otherParticipants.first
        
            if let otherParticipant = otherParticipant {
                
                
                
                
                
                HStack (spacing:28) {
                    
                    
                    ProfileImage(user: otherParticipant)
                    
                    VStack(alignment:.leading,spacing:10) {
                        Text("\(otherParticipants[0].firstName ?? "") \(otherParticipants[0].lastName ?? "")")
                            .font(.bodyText)
                        
                        Text(chat.lastMessage ?? "")
                            .font(.bodyText)
                            .foregroundColor(.secondary)
                        
                    }
                    
                    
                    Spacer()
                    
                    Text(chat.updated == nil ? "" : DateHelper.chatTimestampFrom(date: chat.updated!))
                        .font(.bodyText)
                        .foregroundColor(.secondary)
                    
                }
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
    }
}



struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chat: Chat(numParticipants: 0, participantIDs: [String]()))
    }
}
