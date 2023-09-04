//
//  ContactsPicker.swift
//  ChatApp
//
//  Created by Alfie Downing on 31/08/2023.
//

import SwiftUI

struct ContactsPicker: View {
    @Binding var isContactsPickerShowing: Bool
    @State var selectedContacts: [User] = [User]()
    var body: some View {
        Text("Hello, World!")
        
        
    }
}

struct ContactsPicker_Previews: PreviewProvider {
    static var previews: some View {
        ContactsPicker(isContactsPickerShowing: .constant(true))
    }
}
