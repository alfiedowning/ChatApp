//
//  Logo.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [Color("logoStart"), Color("logoEnd")], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(30)
                .frame(width: 150, height: 150)
            
            Text("C")
                .font(.custom("Montserrat-Light", size: 50))
                .foregroundColor(.white)
                .bold()
            
        }
        
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
