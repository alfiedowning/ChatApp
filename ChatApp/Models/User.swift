//
//  User.swift
//  ChatApp
//
//  Created by Alfie Downing on 20/08/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable{
    @DocumentID var id: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var photo: String?
    
}
