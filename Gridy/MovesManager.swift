//
//  MovesManager.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/30/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct MovesManager {
    
    // counter for number of times hint was pressed
    var hintCounter: Int = 0
    // counter for number of moves made
    var movesMade: Int = 0
    // func to conver string to int for comparison
    func stringToInt(string: String) -> Int {
        let convert: Int? = Int(string)
        return convert!
    }
    // compare no. of moves made on screen to no. of moves, if not equal then update label
    func updateMoves(counter label: UILabel, for mode: GameManager.GameMode) {
            let convertedString = stringToInt(string: label.text!)
            if movesMade != convertedString {
                label.text = "\(movesMade)"
        }
    }
    // Move was made - increment moves made value update moves counter
    mutating func addOntoMoves(counter: UILabel, mode: GameManager.GameMode) {
        if mode == .moves {
            movesMade += 1
            updateMoves(counter: counter, for: mode)
            print("movesMade: \(movesMade)")
        }
    
    }
    
    
    
}
