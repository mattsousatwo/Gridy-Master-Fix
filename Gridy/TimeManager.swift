//
//  TimeManager.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/30/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct TimeManager {
    
    
    
    
    var timer: Timer?
    
    var score = 1000
    // Value of time in seconds
    var timeValue = 0
    // String to represent time as MM:SS
    var clock: String = ""
    
    
    // func to display clock in MM:SS format
    func timeString(interval: Int) -> String {
        let minutes = interval / 60
        let seconds = interval % 60
        
        return String.init(format: "%02i:%02i", minutes, seconds)
    }
    
}
