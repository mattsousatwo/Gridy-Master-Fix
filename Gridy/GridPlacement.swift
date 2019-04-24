//
//  GridPlacement.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/24/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class GridPlacement {

    let gridSize = 4
    
    // :: Inital Tile Bay (Top Area) ::
    // Get Positions of tiles in Inital Grid and store them in an array
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
    
    
    
    // :: Grid (Bottom Area) ::
    // creates cells inside target area and stores them in an array
    func createGridLocations(in gridView: UIView) -> [CGPoint] {
        var pointsArray = [CGPoint]()
        
        
        
        // determine the height of tiles
        let height = (gridView.frame.height) / CGFloat (gridSize)
        let width = (gridView.frame.width) / CGFloat (gridSize)
        
        // iterate through the number of row/columns to create the title and add it to the array
        for y in 0..<gridSize {
            for x in 0..<gridSize {
                // create an image context the size of one tile
                UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
                
                // using the full size image to create a cropped image using the height and width variables and the iterated place in the gridx
                let location = CGPoint.init(x: CGFloat(x) * width, y: CGFloat(y) * height)
                let locationInSuperView = gridView.convert(location, to: gridView.superview)
                // add location to array of locations
                pointsArray.append(locationInSuperView)
            }
        }
        return pointsArray
    }

    
    
    // identifies if the tile is near a grid location and returns the grid poaition if it is near or returns false if not
    func isTileNear(grid: UIView, finalPosition: CGPoint, positions: [CGPoint]) -> (Bool, Int) {
        // iterate through grid locations to identify distance between tile and grid location
        for x in 0..<positions.count {
            let gridPoint = positions[x]
            // for gridPoint in gridLocations {
            // create from and to points
            
            var fromX = finalPosition.x
            var toX = gridPoint.x
            var fromY = finalPosition.y
            var toY = gridPoint.y
            
            // where final position is greater than gridpoint swap from and to points
            
            if finalPosition.x > gridPoint.x {
                fromX = gridPoint.x
                toX = finalPosition.x
            }
            if finalPosition.y > gridPoint.y {
                fromY = gridPoint.y
                toY = finalPosition.y
            }
            
            // calc distance from point to point and how close it needs to be to snap to grid
            let distance = (fromX - toX) * (fromX - toX) + (fromY - toY) * (fromY - toY)
            let halfTileSideSize = (grid.frame.height / CGFloat(gridSize)) / 2.0
            
            if distance < (halfTileSideSize * halfTileSideSize) {
                // valid move update move counter
                return(true, x)
            }
        }
        
        // not close enough to snap to grid
        return(false, 99)
    }
    
    
    
    
    
}

