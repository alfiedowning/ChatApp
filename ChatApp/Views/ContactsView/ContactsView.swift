//
//  ContactsView.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var model: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @State var filterText: String = ""
    @Binding var isChatShwoing: Bool
    var body: some View {
        
        ZStack {
          
            VStack {
                // Heading
                
                HStack {
                    
                    Text("Contacts")
                        .font(.majorHeading)
                    Spacer()
                    
                    Button {
                        // TODO: settings
                    } label: {
                        
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width:20, height: 20)
                        
                    }
                    
                }
                .padding(.horizontal)
                
                
                // Search bar
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                        
                        Spacer()
                        
                        TextField("Search contacts", text: $filterText)
                        
                        
                        
                    }
                    .padding(.horizontal)
                    
                }
                .frame(height:46)
                .padding(.horizontal)
                .onChange(of: filterText) { value in
                    
                    // filter users
                    model.filterContacts(filterBy: filterText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
                    
                }
                
                
                if model.filteredUsers.count > 0 {
                    // List
                    List(model.filteredUsers) { user in
                        // Display rows
                        
                        Button {
                            
                            // TODO: Display conversation view
                            isChatShwoing = true
                            
                            // Search for existing chat with selected user
                            
                            chatViewModel.getChatFor(contact: user)
                            
                            
                        } label: {
                            
                            ContactRow(user: user)
                               
                        }
                        .buttonStyle(.plain)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)

        
                    }
                    .listStyle(.plain)
                    
                    
                    
                } else {
                    
                    Spacer()
                    // TODO: Show empty contacts view
                    
                    NoEntryView()
                    
                    
                }
                
                
                Spacer()
            }
            
            
        }

    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(isChatShwoing: .constant(false))
            .environmentObject(ContactsViewModel())
            .environmentObject(ChatViewModel())
    }
}

struct NoEntryView: View {
    var image: String = "person"
    var mainText: String = "Hmmm... zero contacts?"
    var subText: String = "Try saving some contacts on your phone."
    var body: some View {
        VStack(spacing:30) {
            
            
            Image(systemName: "person")
                .resizable()
                .frame(width:50,height:50)
            
            Text(mainText)
                .font(.largeHeading)
            
            Text(subText)
                .font(.bodyText)
            
            
            
        }
        .padding(.horizontal)
    }
}
