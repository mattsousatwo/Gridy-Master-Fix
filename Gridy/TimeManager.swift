//
//  TimeManager.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/30/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class TimeManager {

    let mm = MovesManager()
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
    func updateGame(mode: GameManager.GameMode, label: UILabel, value: UILabel, controller: UIViewController ) {
        switch mode {
        case .moves:
            print("moves mode")
            // display labels
            label.text = "moves:"
            value.text = "\(mm.movesMade)"
            
            
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
            // use value to display time value
            // use controller to preformSegue
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdownTimer), userInfo: (value, controller), repeats: true)
            
        }
    }
    
    // Action to control countdown
    @objc func countdownTimer() {
        timeValue -= 1
        score -= 3
    
        clock = timeString(interval: timeValue)
        
        guard let (valueLabel, controller) = timer?.userInfo as? (UILabel, UIViewController) else {
            print("-- countdownTimer.userInfo not registered")
            return
        }
        valueLabel.text = clock
        print("CDTimer = \(clock)")
        
        if timeValue <= 0 {
            stopTimer()
            
            // go to next VC
            controller.performSegue(withIdentifier: "GameOverSegue", sender: self)
        }
        
    }
    
    // Action to control time elapsed
    @objc func gameTimer() {
        timeValue += 1
        
        print("-- Time Elapsed = \(timeValue) seconds")
    }
    
    // return final score
    func getScore() -> Int {
        let finalScore = (score - (mm.hintCounter * 2))
        return finalScore
    }
    
}
