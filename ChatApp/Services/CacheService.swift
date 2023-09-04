//
//  CacheService.swift
//  ChatApp
//
//  Created by Alfie Downing on 24/08/2023.
//

import Foundation
import SwiftUI

class CacheService {
    
    // key is the URL
    private static var imageCache = [String: Image]()
    
    // Get image if exists
    static func getImage(forKey: String) -> Image? {
        return imageCache[forKey]
        
    }
    
    // Set image for key
    static func setImage(image: Image, forKey: String) {
        imageCache[forKey] = image
    }
    
}
