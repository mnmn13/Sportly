//
//  Time.swift
//  Sportly
//
//  Created by MN on 08.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

//public class Time {
//    let currentDate =
//}

public struct Time {
    
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    
    public func getTimeStampString() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestampString = dateFormatter.string(from: currentDate)
        return timestampString
    }
    
    
    
}
