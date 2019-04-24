//
//  GridPlacement.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/24/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class GridPlacement {

    var tilePositions = [CGPoint]()
    
    
    func getInitalGridPositions(from container: [Tile]) -> [CGPoint] {
        var returnArray = [CGPoint]()
        
        for tile in container {
            
            let position = tile.frame.origin
            
            returnArray.append(position)
            
        }
        
        return returnArray
    }
    
    
    
    // function to recognize if tile is above inital tile locations bay
    func isNearTileBay(finalPosition: CGPoint, positions: [CGPoint]) -> (Bool, Int) {
        
        // iterate through grid locations
        for x in 0..<positions.count {
            let gridPoint = positions[x]
            
            // for gridPoint in initalGridLocations
            // create from and to points
            var fromX = finalPosition.x
            var toX = gridPoint.x
            var fromY = finalPosition.y
            var toY = gridPoint.y
            
            // if final pos is greater than gridPoint then swap
            if finalPosition.x > gridPoint.x {
                fromX = gridPoint.x
                toX = finalPosition.x
            }
            
            if finalPosition.y > gridPoint.y {
                fromY = gridPoint.y
                toY = finalPosition.y
            }
            // calc distance from point to point
            let distance = (fromX - toX) * (fromX - toX) + (fromY - toY) * (fromY - toY)
            let halfTileSideSize = (54 / 2)
            
            
            // if tile is within half distance to drop location, snap to grid
            if Int(distance) < (halfTileSideSize * halfTileSideSize) {
                return (true, x)
            }
            
            
            
        }
        // 99 - index out of bounds
        return (false, 99 )
    }
}

