//
//  ContentView.swift
//  ChatApp
//
//  Created by Alfie Downing on 19/08/2023.
//

import SwiftUI

struct RootView: View {
    @State var selectedTab: Tabs = .contacts
    @State var isOnBoarding: Bool = !AuthViewModel.isUserLoggedIn()
    @State var isChatShowing: Bool = false
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactViewModel: ContactsViewModel
    // For detecting when the app state changes
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        
        ZStack {
            
            Color(.gray).opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                
                switch selectedTab {
                    
                case .chats:
                    
                    ChatListView(isChatShwoing: $isChatShowing)
                    
                case .contacts:
                    ContactsView(isChatShwoing: $isChatShowing)
                    
                    
                }
                
                Spacer()
                
                
                TabView(selectedTab: $selectedTab, isChatShowing: $isChatShowing)

            }
            
                        
            
        }
            
            
        
        .fullScreenCover(isPresented: $isOnBoarding) {
            
            // The onboarding sequence
            
            OnboardingContainerView(isOnboarding: $isOnBoarding)
            
            
        }
        
        .fullScreenCover(isPresented: $isChatShowing) {
            
            // TODO: Dismiss chat window
            
        } content: {
            
            // Conversation view
            
            ConversationView(isChatShowing: $isChatShowing)
            
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                chatViewModel.closeChatListViewListeners()
            }
        }
        .onAppear {
            
            
            // TODO: Fix this to allow contacts to update
//            if model.filteredUsers.count == 0 {
//                model.getLocalContacts()
//
//            }
            
            if !isOnBoarding {
                contactViewModel.getLocalContacts()
            }
        }
        
        

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(ChatViewModel())
    }
}
