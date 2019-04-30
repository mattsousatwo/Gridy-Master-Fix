//
//  TimeManager.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/30/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct TimeManager {
    
    // func to display clock in MM:SS format
    func timeString(interval: Int) -> String {
        let minutes = interval / 60
        let seconds = interval % 60
        
        return String.init(format: "%02i:%02i", minutes, seconds)
    }
    
}
