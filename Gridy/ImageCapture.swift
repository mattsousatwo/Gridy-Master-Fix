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
        print("~[Capture Image]~")
        UIGraphicsBeginImageContextWithOptions(from.bounds.size, false, 0)
        from.drawHierarchy(in: from.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return screenshot
        
    }
    
    // didnt work
    // tried to take screenshot of area instead of view -- maybe didnt accomplish this --
            // can solve by adding tiles as subviews of gidview 
    func takeScreenshot(from area: UIView) -> UIImage? {
        var image: UIImage?
        //     let currentLayer = ImageView.layer
        let captureLayer = area.layer
        let currentScale = area.layer.contentsScale
        //  UIGraphicsBeginImageContextWithOptions(currentLayer.frame.size, false, currentScale)
        UIGraphicsBeginImageContextWithOptions(area.frame.size, false, currentScale)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        //  currentLayer.render(in: currentContext)
        captureLayer.render(in: currentContext)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let img = image else {
            return nil
            
        }
        return img
        
    }
    
    

}
