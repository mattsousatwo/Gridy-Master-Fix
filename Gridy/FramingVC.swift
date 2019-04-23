//
//  FramingVC.swift
//  Gridy
//
//  Created by Matthew Sousa on 11/28/18.
//  Copyright © 2018 Matthew Sousa. All rights reserved.
//

import UIKit

class FramingVC: UIViewController, UIGestureRecognizerDelegate {
    
    // :: Variables ::
    // image variable to store a picked image from the previous view
    var imageHolder2 = UIImage() 
    // referencing to class
    var slicing = Slicing()
    // referencing to class
    var capture = ImageCapture()
    
    
    // :: Outlets ::
    // UIImageView inside captureArea to display chosen game image
    @IBOutlet weak var selectedImageView: UIImageView!
    // UIView to define the primeter in which the game image will be cropped at
    @IBOutlet weak var captureArea: UIView!
    // Background Image to display grid
    @IBOutlet weak var gridBackground: UIImageView!
    // Outlet for Start Button
    @IBOutlet weak var startButton: UIButton!
    
    
    
    // :: Buttons ::
    
    // Cancel Button top right of screen - unwind to HomeVC
    @IBAction func cancelButton(_ sender: Any) {
        print("\no<-X CancelButton()")
        
        // remove current image
        selectedImageView.image = nil
    }
    
    
    // Action Outlet for the start button - slice images, go to PlayfieldVC
    @IBAction func startButtonPressed(_ sender: Any) {
        // Go to PlayfieldVC
        print("-> GoToPlayfieldVC")
        
        // Capture Image from captureArea
        capture.captureImage(from: captureArea)
        
        // Slice Image
        print("~x~ SliceImage()")
        slicing.sliceImage(for: capture.gameImage, row: 4, column: 4)
        
    }
    
    
    // :: Gestures ::
    
    // storing inital position of image in selectedImageView as a variable
    var initalImageViewOffset = CGPoint()
    
    // Allowing the image in selectedImageView to move
    // setting functionality for pan gesture recognizer in selectedImageView
    @objc func moveImageView(_ sender: UIPanGestureRecognizer) {
        print("moving")
        
        // storing the value of the user moving the selectedImageView as a CGPoint value
        let translation = sender.translation(in: selectedImageView)
        
        // if gesture recognizer touches began
        if sender.state == .began {
            
            initalImageViewOffset = selectedImageView.frame.origin
            
        }
        
            // adding user panning as a CGPoint Value
            let position = CGPoint(x: translation.x + initalImageViewOffset.x - selectedImageView.frame.origin.x, y: translation.y + initalImageViewOffset.y - selectedImageView.frame.origin.y)
            
            // declaring image to transform by user panning.x and user panning.y
            selectedImageView.transform = selectedImageView.transform.translatedBy(x: position.x, y: position.y )
        
    }
    
    
    // allowing the image in selectedImageView to rotate
    @objc func rotateImageView(_ sender: UIRotationGestureRecognizer) {
        print("rotating")
        
        // transforming selectedImageView by users rotation value
        selectedImageView.transform = selectedImageView.transform.rotated(by: sender.rotation)
        
        // reseting the rotation value to 0 ( default )
        // so that when the user decides to rotate again, we are only applying a the new rotation value
        sender.rotation = 0
    }
    
    // allowing scaling to image in selectedImageView
    @objc func scaleImageView(_ sender: UIPinchGestureRecognizer) {
        print("scaling")
        
        // scaling selectedImageView by users scaling value
        selectedImageView.transform = selectedImageView.transform.scaledBy(x: sender.scale, y: sender.scale)
        
        // reseting scaling value to 1 ( default )
        // so that when the users decides to scale the image again, we are only applying the new scaling value
        sender.scale = 1
    }
    
    // simultanious gesture recognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        // if gestureRecognizer is not applied to selectedImageView -> do not execute
        if gestureRecognizer.view != selectedImageView {
            return false
        }
        
        // if gestureRecognizer Pan or Tap Gesture -> do not execute
        if gestureRecognizer is UITapGestureRecognizer || otherGestureRecognizer is UITapGestureRecognizer || gestureRecognizer is UIPanGestureRecognizer || otherGestureRecognizer is UIPanGestureRecognizer {
            return false
        }
        
        // if gestureRecognizer is applied to selectedImageView then execute simultanious gestures
        return true
    }
    
    // Set up FramingViewController ; apply gestures to image view
    func configureFramingView() {
        
        // disable interaction with grid image
        gridBackground.isUserInteractionEnabled = false
        
        // assigning selected || taken photo to the imageView
        selectedImageView.image = imageHolder2
        // enable interaction with ImageView
        selectedImageView.isUserInteractionEnabled = true
    
        // rounding edges to start button 
        startButton.layer.cornerRadius = 12
        
        // pan gesture recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveImageView(_:)))
        // adding pan gesture to selectedImageView
        selectedImageView.addGestureRecognizer(panGestureRecognizer)
        
        panGestureRecognizer.delegate = self 
        
        // rotate gesture recognizer
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotateImageView(_:)))
        // add rotate gesture to selectedImageView
        selectedImageView.addGestureRecognizer(rotationGestureRecognizer)
        // setting gesture rescognizer delegate to self
        rotationGestureRecognizer.delegate = self
        
        // pinch gesture recognizer
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(scaleImageView(_:)))
        // add pinch gesture to selectedImageView
        selectedImageView.addGestureRecognizer(pinchGestureRecognizer)
        // set pinch gesture delegate to self
        pinchGestureRecognizer.delegate = self
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureFramingView()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}   

