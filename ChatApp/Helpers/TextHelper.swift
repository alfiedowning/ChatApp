//
//  TextHelper.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import Foundation

class TextHelper {
    
    static func santisePhoneNumber(phoneNumber: String) -> String {
        let charToRemove = ["(", ")", " " , "-", " ", "+"]
        var phone = phoneNumber
        for char in charToRemove {
            phone = phone.replacingOccurrences(of: char, with: "")
        }
        return phone
    }

}



