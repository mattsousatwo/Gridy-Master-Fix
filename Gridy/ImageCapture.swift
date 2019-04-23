//
//  ImageCapture.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/23/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct ImageCapture {
    
    // Take a screenshot of the contents of a specified UIView
    func captureImage(from: UIView ) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(from.bounds.size, false, 0)
        from.drawHierarchy(in: from.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return screenshot
    }

}
