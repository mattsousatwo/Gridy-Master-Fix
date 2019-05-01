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
        
    }
    
    // bring image on screen
    func presentGame(image: UIView) {
        
    }
    
    
    
    
    
    
    
    
    
}
