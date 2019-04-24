//
//  TileDistribution.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/23/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct TileDistribution {
    
    var tileContainer = [Tile]()
    // tile size - W: 54, H: 54
    let tileSize = CGFloat(54)
    
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
    
    // func to get the location of each subview in the initalGridView and put location into a container to later be shuffled and assigned to another tile
    mutating func getSubviewPositions(from view: [UIView]) {
        // tile location
        if view.isEmpty == false {
            for subview in view {
                
                let imagePosition = subview.frame.origin
                
                // view position + offset value
                let imageX = imagePosition.x + 6
                let imageY = imagePosition.y + 68
                
                let subviewPoint = CGPoint(x: imageX, y: imageY)
     
                // adding adjusted position to tileLocation container for shuffling
                tileLocations.append(subviewPoint)
                
                // remove 17th value from initalTilesGrid == UIView location which contains all the tile subviews
                tileLocations.removeAll(where: {($0).x == 12.0 && ($0).y == 136.0})
            }
            
        } else {
            print("tileLocations has no subviews")
        }
        
    }
    
  
    
    
    
    
}
