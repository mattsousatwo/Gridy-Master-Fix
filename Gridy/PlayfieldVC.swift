//
//  PlayfieldVC.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/22/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class PlayfieldVC: UIViewController, UIGestureRecognizerDelegate {

    // :: Class Reference ::
    let slicing = Slicing()
    
    let capture = ImageCapture()
    
    let manager = GameManager()
    
    // :: Variables ::
    // GameImage To be used for hint display
    var gameImage = UIImage()
    // Container of Sliced Images sent over from FramingVC
    var slicedImages = [UIImage]()
    
    
    // :: Outlets ::
    // Eye Image to display Hint Image
    @IBOutlet weak var hintButton: UIImageView!
    
    
    // :: Buttons ::
    // New Game button - Cancel, go back to HomeVC
    @IBAction func newGamePressed(_ sender: Any) {
        print("\no<-X newGamePressed()")
        
        // remove current game image
        
    }
    
    // Func to display hint image
    @objc func showHint(_ sender: UITapGestureRecognizer) {
        print(" ^%^ Show Hint")
        
        // add onto number of times hint has been pressed
      //  gameStructure.hintCounter += 1
        
        // add blur view
        let blur = UIVisualEffectView()
        blur.frame = self.view.frame
        blur.effect = UIBlurEffect(style: .regular)
        self.view.addSubview(blur)
        
        // Game Image height & width for frame sizing
        let imgWidth = gameImage.size.width
        let imgHeight = gameImage.size.height
       
        // set frame
        let previewImageView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: imgWidth + 25, height: imgHeight + 25))
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: imgWidth, height: imgHeight))
        
        // add view
        self.view.addSubview(previewImageView)
        previewImageView.addSubview(imageView)
        
        // set game image to the preview imageView
        imageView.image = gameImage
        
        // set frame attributes
        previewImageView.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
        // set background color
        previewImageView.backgroundColor = #colorLiteral(red: 0.1350251588, green: 0.2111370802, blue: 0.1540531392, alpha: 1)
        // center views
        imageView.center = previewImageView.center
        previewImageView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        
        view.bringSubviewToFront(previewImageView)
        
        // animate presentation in
        UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            
            previewImageView.center = self.view.center
        }) { (success) in }
        
        // animate presentation out
        UIView.animate(withDuration: 0.5, delay: 1.2, options: .curveEaseIn, animations: {
            
            // move previewImageView off screen
            previewImageView.center = CGPoint(x: self.view.center.x + (self.view.frame.width * 2), y: self.view.center.y)
            
            // remove blurView
            blur.effect = nil
            blur.isUserInteractionEnabled = false
            
        }, completion: { (success) in })
        
        print("Show Hint")
        
    }
    
    
    // :: Gesture Recognizers ::
    func addTapGesture() {
        // Creating TapGestureRecognizer to trigger when showHint should be activated
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showHint(_:)))
        // Adding gesture recognizer to hintButton
        hintButton.addGestureRecognizer(tapGesture)
        // setting gesture delegate to self
        tapGesture.delegate = self
    }
    
    
    
    // :: View Configuration ::
    func configurePlayfield() {
        
        // adding tap gesture to hint button
        addTapGesture()
    }
    
    
    
    // ------ CAN DELETE ----
    func checkSlices() {
        // if tiles array != 0
        guard slicedImages.count != 0 else {
            print("\n ----- there are no tiles -> 0")
            return
        }
            // print array amount
            print("\n ----- tilesArray.count = \(slicedImages.count)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkSlices()
        
        configurePlayfield()
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
