//
//  Gradients.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import Foundation
import SwiftUI



extension LinearGradient {
    static var buttonGradient: LinearGradient {
        return LinearGradient(colors: [Color("buttonStart"), Color("buttonEnd")], startPoint: .leading, endPoint: .trailing)
    }
}
