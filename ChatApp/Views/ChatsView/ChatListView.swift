//
//  ChatListView.swift
//  ChatApp
//
//  Created by Alfie Downing on 22/08/2023.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactViewModel: ContactsViewModel
    @Binding var isChatShwoing: Bool
    var body: some View {
        
        VStack {
            
    
            // Header view
            HStack {
                
                Text("Chats")
                    .font(.majorHeading)
                Spacer()
                
                Button {
                    // TODO: settings
                    
                    AuthViewModel.logOut()
                } label: {
                    
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width:20, height: 20)
                    
                }
                
            }
            .padding(.horizontal)
            
            
            
            
            // Chat list
            
            if chatViewModel.chats.count > 0 {
                
                List(chatViewModel.chats) { chat in
                    
                    Button {
                        
                        chatViewModel.selectedChat = chat
                        isChatShwoing = true
                        
                    } label: {
                        
//                        let participantIDs = chatViewModel.getParticipantIDs()
//                        ChatRow(otherParticipants: contactViewModel.filteredUsers.filter({ user in
//                            return participantIDs.contains(user.id ?? "")
//                        }), chat: chat)
//
                        
                        ChatRow(otherParticipants: contactViewModel.getParticipants(ids: chat.participantIDs), chat: chat)
                        
                        


                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                    
                    
                }
                .listStyle(.plain)
            } else {
                
                Spacer()
                NoEntryView(mainText: "Hmmm... no chats?", subText: "Go to contacts and start a chat.")
            }
            
            
            
            
            Spacer()
            
            
            
        }


        
        
        
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(isChatShwoing: .constant(false))
            .environmentObject(ChatViewModel())
            .environmentObject(ContactsViewModel())
    }
}
