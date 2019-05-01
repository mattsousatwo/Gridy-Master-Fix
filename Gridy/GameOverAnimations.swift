//
//  GameOverAnimations.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/30/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct GOAnimations {
    
    // round top edges
    func roundEdges(of view: UIView) {
        view.layer.cornerRadius = 10
        // round top left & top right corners
        view.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner ]
    }
    
    // bring scoreboard on screen
    func present(scoreboard: UIView) {
        
        let origin = scoreboard.frame.origin
        // animate view off screen
        UIView.animate(withDuration: 0.0, animations: {
            scoreboard.frame.origin = CGPoint(x: origin.x, y: origin.y + 250)
        })
       // animate view on screen
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            scoreboard.frame.origin = CGPoint(x: origin.x, y: origin.y - 250)
            
            }, completion: nil)
        
    }
    
    // bring image on screen
    func presentGame(image: UIView) {
        
    }
    
    
    
    
}
