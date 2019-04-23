//
//  TileDistribution.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/23/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct TileDistribution {
    
    // Container to store possible inital tile locations in PlayfieldVC
    var tileLocations = [CGPoint]()
    
    // shuffle items in initalTileLocations then return a shuffled point if tileLocations is not empty
    mutating func shuffledTileLocation() -> CGPoint? {
        
        var point = CGPoint()
        
        // if initalTileLocations is not empty
        if tileLocations.count != 0 {
            
            // shuffle objects(CGPoint) in array
            tileLocations.shuffle()
            
            // assign first element to point
            point = tileLocations[0]
            
            // remove first element in array
            tileLocations.remove(at: 0)
            
            return point
        }
        
        return nil
    }

    
    // :: Setting Tile Position ::
    // Each tile is offset by a certain amount of points because it is a subview of another view
    
    // Methods to easily set position for UIView
    func getXViewPosition(from view: UIView) -> CGFloat {
        // x: 6
        let xOffsetEquation = view.frame.origin.x + 6
        return xOffsetEquation
    }
    
    func getYViewPosition(from view: UIView) -> CGFloat {
        // y: 68
        let yOffsetEquation = view.frame.origin.y + 68
        return yOffsetEquation
    }
    
    
}
