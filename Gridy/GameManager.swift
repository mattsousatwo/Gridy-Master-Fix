//
//  GameManager.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/23/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit


class GameManager {
    
    let tm = TimeManager()
    // :: Handling Game Mode ::
    // Enumeration to handle the game mode
    enum GameMode {
        case timed
        case moves
    }
    
    
    // :: Check for Completion
    // Check if all tiles are in correct positions
    func checkForCompletion(_ array: [Tile]) -> Bool { 
        
        // If all tiles in tile container are in correct tile position return true
        let allTilesCorrect = array.allSatisfy { $0.isInCorrectPosition == true }
        
        // If tiles are in correct position go to game over screen
        if allTilesCorrect == true {
            print("\n*** All in Correct Positions! ***\n")
            
             // remove ability to move tiles
            for tile in array {
                tile.isUserInteractionEnabled = false
            }
            
            return true
            
        }
        else {
            // else continue game
            print("\n---- Not all tiles are in correct positions\n")
        return false
        }
        
    }
    
    // display game image for a short time with a blur view bg  
    func displayHint(image: UIImage, in view: UIView) {
        print("\n ^%^ Show Hint\n")
        
        // add blur view
        let blur = UIVisualEffectView()
        blur.frame = view.frame
        blur.effect = UIBlurEffect(style: .regular)
        view.addSubview(blur)
        
        // Game Image height & width for frame sizing
        let imgWidth = image.size.width
        let imgHeight = image.size.height
        
        // set frame
        let previewImageView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: imgWidth + 25, height: imgHeight + 25))
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: imgWidth, height: imgHeight))
        
        // add view
        view.addSubview(previewImageView)
        previewImageView.addSubview(imageView)
        
        // set game image to the preview imageView
        imageView.image = image
        
        // set frame attributes
        previewImageView.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
        // set background color
        previewImageView.backgroundColor = #colorLiteral(red: 0.1350251588, green: 0.2111370802, blue: 0.1540531392, alpha: 1)
        // center views
        imageView.center = previewImageView.center
        previewImageView.center = CGPoint(x: view.center.x, y: view.center.y)
        
        view.bringSubviewToFront(previewImageView)
        
        // animate presentation in
        UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            
            previewImageView.center = view.center
        }) { (success) in }
        
        // animate presentation out
        UIView.animate(withDuration: 0.5, delay: 1.2, options: .curveEaseIn, animations: {
            
            // move previewImageView off screen
            previewImageView.center = CGPoint(x: view.center.x + (view.frame.width * 2), y: view.center.y)
            
            // remove blurView
            blur.effect = nil

        }, completion: { (success) in
            
            // remove views
            view.willRemoveSubview(blur)
            view.willRemoveSubview(previewImageView)
            blur.removeFromSuperview()
            previewImageView.removeFromSuperview()
            
        })
        
    }
    
}
