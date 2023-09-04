//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Alfie Downing on 19/08/2023.
//

import SwiftUI
import FirebaseCore

@main
struct ChatAppApp: App {
    // register app delegate for Firebase setup
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ContactsViewModel())
                .environmentObject(ChatViewModel())
        }
    }
}
