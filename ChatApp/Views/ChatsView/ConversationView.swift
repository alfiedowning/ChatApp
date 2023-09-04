//
//  ConversationView.swift
//  ChatApp
//
//  Created by Alfie Downing on 22/08/2023.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State var participants: [User] = [User]()
    @Binding var isChatShowing: Bool
    @State var chatMessage: String = ""
    @State var isContactPickerShowing = false
    var body: some View {
        
        VStack(spacing:0) {
            
            // Chat header
            
            HStack {
                
                
                VStack(alignment:.leading,spacing: 20) {
                    
                    HStack {
                        Button {
                            isChatShowing = false
                        } label: {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width:20, height:20)
                        }
                        
                        .foregroundColor(.black)
                        
                        if participants.count  == 0 {
                            Text("New Message")
                                .font(.largeHeading)
                                .bold()
                        }
                        
                        
                    }
                    
                    if participants.count > 0 {
                        
                        Text("\(participants.first!.firstName ?? "") \(participants.first!.lastName ?? "")")
                            .font(.largeHeading)
                            .bold()
                        
                    } else{
                        Text("Recipient")
                            .font(.bodyText)
                            .foregroundColor(.secondary)
                    }
                    
                }
                
                
                
                Spacer()
                
                
                if participants.count > 0 {
                    
                    ProfileImage(user: participants.first ?? User())
                    
                } else {
                    
                    Button {
                        isContactPickerShowing = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:25, height:25)
                    }

                    
                }
                
                
            }
            .frame(height:104)
            .padding(.horizontal)

            
            Spacer()
            
            
            // Chat log

            ZStack {
                
                Color.secondary.opacity(0.3)
                
                ScrollViewReader { proxy in
                
                    ScrollView{
                        
                        
                        
                        VStack(spacing:24) {
                            
                            
                            
                            // Loop through messages array
                            ForEach (Array(chatViewModel.messages.enumerated()), id: \.element) { index, message in
                                
                                // Dynamic message
                                
                                let messageFromUser = message.senderID == AuthViewModel.getLoggedInUserID()
                                
                                HStack {
                                    
                                    if messageFromUser {
                                        
                                        // Timestamp
                                        
                                        // Spacer
                                        
                                        
                                        Text(DateHelper.chatTimestampFrom(date: message.timestamp ?? Date()))
                                            .font(.caption)
                                            .foregroundColor(.black.opacity(0.5))
                                            .padding(.leading)
                                        
                                        
                                        Spacer()
                                        
                                        
                                        
                                    }
                                    
                                    
                                    // Message
                                    
                                    Text(message.msg)
                                        .font(.bodyText)
                                        .foregroundColor(messageFromUser ? .black.opacity(0.5) : .black.opacity(0.5))
                                        .padding(.vertical,16)
                                        .padding(.horizontal, 24)
                                        .background(messageFromUser ? Color.blue.opacity(0.6) : Color.blue.opacity(0.1))
                                        .cornerRadius(20, corners: messageFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                                    
                                    
                                    
                                    if !messageFromUser {
                                        Spacer()
                                        
                                        Text(DateHelper.chatTimestampFrom(date: message.timestamp ?? Date()))
                                        
                                            .font(.caption)
                                            .foregroundColor(.black.opacity(0.5))
                                            .padding(.trailing)
                                    }
                                    
                                }.id(index)
                                
                                
                            }
                            
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 24)
                        .padding(.bottom, 10)
                        
                        
                    }
                    .onChange(of: chatViewModel.messages.count) { newCount in
                        
                        withAnimation {
                            proxy.scrollTo(newCount-1)

                        }
                    }
                    
                    
                    
                    
                    
                }
                
            }
            
            
            // Chat message bar
            
                
                
            HStack(spacing:15) {
                    
                    
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.secondary)
                        .frame(width:24,height: 24)
                    
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.white)
                            .frame(height:44)
                        
                        HStack {
                            TextField("Aa", text: $chatMessage)
                                .font(.bodyText)
                                .padding(10)
                            
                            Spacer()
                        
                            
                        }
                        

                        
                    }

                    
                Button {
                    
                    
                    // TODO: Clean message
                    
                    
                    
                    
                    chatViewModel.sendMessage(message: chatMessage)
                    chatMessage = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(Color("logoStart"))
                        .frame(width:24,height: 24)
                    
                }

                   
                    
                }
                .frame(height:76)
                .padding(.horizontal)
                .background(Color.secondary.opacity(0.2))
                .disabled(participants.count == 0)
            


                
                
                
        
            
        }
        
        .onAppear {
            // Get messages
            
            chatViewModel.getMessages()
            
            // Get ids for other participants
            let ids = chatViewModel.getParticipantIDs()
            self.participants = contactsViewModel.getParticipants(ids: ids)
            
            
            
        }
        .onDisappear {
            chatViewModel.closeConversationViewListeners()
        }
        .sheet(isPresented: $isContactPickerShowing) {
            
            // When dismissed
            
        } content: { 
            
            ContactsPicker(isContactsPickerShowing: $isContactPickerShowing, selectedContacts: self.participants)
            
        }


            

            
            
            
            
            
            
            
            
            
            
        }
        
        
        
    
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(true))
            .environmentObject(ChatViewModel())
            .environmentObject(ContactsViewModel())
    }
}
