//
//  ContactRow.swift
//  ChatApp
//
//  Created by Alfie Downing on 22/08/2023.
//

import SwiftUI

struct ContactRow: View {
    var user: User = User(id: "", firstName: "Kate", lastName: "Bell", phone: "+447123 143891")
    var body: some View {
        HStack (spacing:28){
            
            
            ProfileImage(user: user)


            

            VStack(alignment:.leading,spacing:10) {
                Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                    .font(.bodyText)
                
                Text(user.phone ?? "")
                    .font(.bodyText)
                    .foregroundColor(.secondary)
                
            }
            
            
            Spacer()
            
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow()
    }
}
