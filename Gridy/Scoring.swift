//
//  Scoring.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/25/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class Scoring {
    
    // Reference to PlayfieldVC
    let playfield = PlayfieldVC()
    // timer
    var timer: Timer?
    
    // :: Variables ::
    // variable for moves made
    var movesMade: Int = 0
    // time value in seconds
    var timeValue: Int = 0
    // score
    var score = 1000
    // hint counter
    var hintCounter: Int = 0
    
    // return final score
    func getScore() -> Int {
        let finalScore = (score - (hintCounter * 2))
        return finalScore
    }
    
    // func to display clock in MM:SS format
    func timeString(interval: Int) -> String {
        let minutes = interval / 60
        let seconds = interval % 60
        
        return String.init(format: "%02i:%02i", minutes, seconds)
    }
    
    // func to convert moves counter label to an Int for comparison
    func stringToInt(string: String) -> Int {
        let convert: Int? = Int(string)
        return convert!
    }
    
    // func to update moves counter display while moves mode is running
    func checkCounter(label: UILabel, mode: GameManager.GameMode) {
        if mode == .moves {
            // string to compare current calue to displayed value
            let comparisonString = stringToInt(string: label.text!)
            if movesMade != comparisonString {
                label.text = "\(movesMade)"
            }
        }
    }
    
    
    
    // Func to control Timer Countdown - to determine time passed in game
    
    
    
    // Func to control game timer - to calc time elapsed
    
    
    
    
    
    
    
    
    
}
