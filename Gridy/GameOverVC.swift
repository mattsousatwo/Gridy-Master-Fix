//
//  GameOverVC.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/30/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class GameOverVC: UIViewController {
    
    // :: Refrences ::
    let animations = GOAnimations()
    
    

    // :: Outlets ::
    // view to display game image
    @IBOutlet weak var gameImageView: UIImageView!
    // view to contain scores
    @IBOutlet weak var scoreboard: UIView!
    // score label
    @IBOutlet weak var sbLabelOne: UIView!
    // time left label
    @IBOutlet weak var sbLabelTwo: UIView!
    // hint pressed label
    @IBOutlet weak var sbLabelThree: UIView!
    // play again outlet
    @IBOutlet weak var playAgainButton: UIButton!
    // share outlet
    @IBOutlet weak var shareButton: UIButton!
    
    // :: Buttons ::
    // play again action
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        print("- playAgain")
    }
    // share action
    @IBAction func shareButtonPressed(_ sender: Any) {
        print("- shareButton")
    }
    
    // :: Configuration ::
    func configureView() {
        animations.roundEdges(of: scoreboard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
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
