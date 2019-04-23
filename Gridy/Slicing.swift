//
//  Slicing.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/23/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

struct Slicing {
    
    // variable to hold sliced images for tiles
    var slicedImageArray: [UIImage] = []
    
    // create an array of slices from an image using the desired amount of columns and rows, then store that array inside another array
    mutating func sliceImage(for image: UIImage, row: Int, column: Int) {
        
        // divide image height by number of rows as! CGFloat
        let height = (image.size.height) / CGFloat (row)
        let width = (image.size.width) / CGFloat (column)
        
        // scale conversion factor is needed as UIImage makes use of "points" whereas CGImage uses pixels
        let scale = (image.scale)
        
        // empty array of arrays of images
        var imageArray = [UIImage]()
        
        // for each in 0 ... number of rows
        for y in 0..<row {
            
            // for each in 0 ... number of columns
            for x in 0..<column {
                
                // creating a bitmap of an image with specific options
                // size = width & height, opacity = false, scale = 0
                UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
                
                // creating a slice of the image
                let i = image.cgImage?.cropping(to: CGRect.init(x: CGFloat(x) * width * scale, y:  CGFloat(y) * height * scale , width: width * scale, height: height * scale)  )
                
                // add slice of image
                let newImage = UIImage.init(cgImage: i!)
                
                // add newImage to yArray
                imageArray.append(newImage)
                
                // end drawing image
                UIGraphicsEndImageContext();
                
            }
            
        }
        
        // return imageArray
        slicedImageArray = imageArray
        
    }
    
    // Remove Images from slicedImageArray
    mutating func removeImages() {
        if slicedImageArray.count != 0 {
            print("[*] removing slices from slicedImageArray \n")
            slicedImageArray.removeAll()
            
        } else {
            
            print("-- slicedImageArray.count = 0 \n")
            
        }
    }
    
    
    
    
    
}
