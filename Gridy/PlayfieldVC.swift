//
//  PlayfieldVC.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/22/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class PlayfieldVC: UIViewController, UIGestureRecognizerDelegate {

    // :: Variables ::
    
    let slicing = Slicing()
    
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
