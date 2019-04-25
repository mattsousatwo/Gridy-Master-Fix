//
//  GameManager.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/23/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit


class GameManager {
    
    // Check if all tiles are in correct positions
    func checkForCompletion(_ array: [Tile]) {
        
        // If all tiles in tile container are in correct tile position return true
        let allTilesCorrect = array.allSatisfy { $0.isInCorrectPosition == true }
        
        // If tiles are in correct position go to game over screen
        if allTilesCorrect == true {
            print("\n*** All in Correct Positions! ***\n")
            
            // if game in timed mode
//            if timeMode == true {
//                // turn timer off
//                gameStructure.timer?.invalidate()
//                gameStructure.timer = nil
//            }
//
            // go to game over screen - with delay
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//                self.performSegue(withIdentifier: "goToGameOverVC", sender: self)
//            })
            
             // remove ability to move tiles
//            for tile in array {
//                tile.isUserInteractionEnabled = false
//            }
        }
        else {
            // else continue game
            print("\n---- Not all tiles are in correct positions\n")
        }
        
    }
}
