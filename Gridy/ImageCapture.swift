//
//  ImageCapture.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/23/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct ImageCapture {
    
    var gameImage = UIImage()
    
    // Take a screenshot of the contents of a specified UIView
    mutating func captureImage(from: UIView ) {
        UIGraphicsBeginImageContextWithOptions(from.bounds.size, false, 0)
        from.drawHierarchy(in: from.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        gameImage = screenshot
    }

}
