//
//  GameOverVC.swift
//  Gridy
//
//  Created by Matthew Sousa on 4/30/19.
//  Copyright © 2019 Matthew Sousa. All rights reserved.
//

import UIKit

class GameOverVC: UIViewController {
    
    // :: References ::
    let animations = GOAnimations()
    let time = TimeManager()
    
    // :: Variables ::
    // mode
    var gameMode: GameManager.GameMode = .moves
    // game image
    var gameImage = UIImage()
    // Game Over Label Text
    var gameOverDisplay = "Game Over"
    // # of times hint was pressed
    var hintCount = 0
    // :: Time Scoreboard Values ::
    // score value
    var finalScore = 0
    // time value
    var timeLeft = 0
    // :: Moves Scoreboard Values ::
    // moves counter
    var movesCount = 0
    // time elapsed
    var timeElapsed = 0
    // message to be shared
    var shareMessage = ""
    
    
    // :: Outlets ::
    // view to display game image
    @IBOutlet weak var gameImageView: UIImageView!
    // view to contain scores
    @IBOutlet weak var scoreboard: UIView!
    // Game Over Label
    @IBOutlet weak var gameOverLabel: UILabel!
    // score / moves label
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreLabelValue: UILabel!
    // time left / time elapsed label
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelValue: UILabel!
    // hint pressed label
    @IBOutlet weak var hintCountLabel: UILabel!
    @IBOutlet weak var hintCountLabelValue: UILabel!
    
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
        let message = shareMessage
        let image = gameImage
        let items = [image as Any, message as Any]
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        print(message)
        
    }
    
    
    // func to display scoreboard labels
    func presentScoreboardLabels() {
        
        gameImageView.image = gameImage
        hintCountLabelValue.text = "\(hintCount)"
        gameOverLabel.text = "\(gameOverDisplay)"
        
        switch gameMode {
        case .moves:
            print("- present moves scoreboard")
            scoreLabel.text = "Moves"
            scoreLabelValue.text = "\(movesCount)"
            timeLabel.text = "Time Elapsed"
            timeLabelValue.text = time.timeString(interval: timeElapsed)
            // produce share message
            shareMessage = "I finished this puzzle in \(movesCount) moves and only in \(timeElapsed) minutes!"
        case .timed:
            print("- present timed scoreboard")
            scoreLabel.text = "Score"
            scoreLabelValue.text = "\(finalScore)"
            timeLabel.text = "Time Left"
            timeLabelValue.text = time.timeString(interval: timeLeft)
            // produce share message
            shareMessage = "I scored \(finalScore) points with only \(timeLeft) left!"
        }
    }
    
    // :: Configuration ::
    func configureView() {
        // round top edges of scoreboard 
        animations.roundEdges(of: scoreboard)
        
        presentScoreboardLabels()
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
