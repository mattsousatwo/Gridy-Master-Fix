//
//  TimeManager.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/30/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class TimeManager {

    
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
    
    // Stop Timer
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    // Update mode labels
    func updateGame(mode: GameManager.GameMode, label: UILabel, value: UILabel) {
        switch mode {
        case .moves:
            print("moves mode")
            // display labels
            label.text = "moves:"
            value.text = "00"
            
            
            // add timer to count time elapsed
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gameTimer), userInfo: nil, repeats: true)
            
        case .timed:
            print("timed mode")
            // set time to 3 mins
            timeValue = 180
            clock = timeString(interval: timeValue)
            
            // display labels
            label.text = "time:"
            value.text = clock
            
            
            // add timer to count down from timeValue
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdownTimer), userInfo: value, repeats: true)
            
        }
    }
    
    // Action to control countdown
    @objc func countdownTimer() {
        timeValue -= 1
        score -= 3
    
        clock = timeString(interval: timeValue)
        
        guard let valueLabel = timer?.userInfo as? UILabel else {
            print("-- countdownTimer.userInfo not registered")
            return
        }
        valueLabel.text = clock
        print("CDTimer = \(clock)")
        
        if timeValue <= 0 {
            stopTimer()
            
            // go to next VC
        }
        
    }
    
    // Action to control time elapsed
    @objc func gameTimer() {
        timeValue += 1
        
        print("-- Time Elapsed = \(timeValue) seconds")
    }
    
    
    
}
