//
//  CustomButton.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import SwiftUI

struct CustomButton: View {
    var text: String = ""
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(LinearGradient.buttonGradient)
            .frame(height:60)
            .overlay {
                Text(text)
                    .foregroundColor(.white)
                    .font(.bodyText)
            }
            .padding(.bottom,10)
    }
}
