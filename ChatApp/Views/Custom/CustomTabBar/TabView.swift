//
//  TabView.swift
//  ChatApp
//
//  Created by Alfie Downing on 19/08/2023.
//

import SwiftUI

enum Tabs: Int {
    case chats = 0
    case contacts = 1
}

struct TabView: View {
    @Binding var selectedTab: Tabs
    @Binding var isChatShowing: Bool
    @EnvironmentObject var model: ContactsViewModel
    var body: some View {
        HStack(alignment:.center) {
            
            Button {
                // Switch to chats
                    selectedTab = .chats

                
            } label: {
                
                Tab(image: "bubble.left", text: "Chats", isActive: selectedTab == .chats)
                
            }
            .tint(.secondary)

            Spacer()
            
            Button {
                
                isChatShowing = true
                                
//                AuthViewModel.logOut()
                
                
                
            } label: {
                
                VStack {
                    
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    
                    Text("New Chat")
                        .font(.bodyText)
                }
                
            }
            
            Spacer()

            Button {
                
                    
                    
                    selectedTab = .contacts
                    
                
            } label: {
                Tab(image: "person", text: "Contacts", isActive: selectedTab == .contacts)

            }


            
        }
        .frame(height:82)
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabView(selectedTab: .constant(.contacts), )
//            .environmentObject(ContactsViewModel()
//            )
//    }
//}



struct Tab: View {
    var image: String
    var text: String
    var isActive: Bool
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                    
                    
                    RoundedRectangle(cornerRadius: 30)
                    .frame(width: isActive ? geo.size.width/2 : 0, height: isActive ? geo.size.width/2 : 0)
                    .padding(.leading,geo.size.width/4)
                    
                        .tint(.blue.opacity(0.3))
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                VStack {
                    
                    
                    
                    
                    Image(systemName: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:24, height: 24)
                    
                    Text(text)
                        .font(.bodyText)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
            
        }
    }
}
