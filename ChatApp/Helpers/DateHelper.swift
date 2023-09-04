//
//  DateHelper.swift
//  ChatApp
//
//  Created by Alfie Downing on 23/08/2023.
//

import Foundation


class DateHelper {
    
     
    static func chatTimestampFrom(date: Date) -> String {
        
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        
        return df.string(from: date)
        
    }
    
    
    
    
    
}
