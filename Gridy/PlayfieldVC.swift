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
    var distributor = TileDistribution()
    let grid = GridPlacement()
    
    // :: Variables ::
    // Game Mode
    var mode: GameManager.GameMode = .moves
    // GameImage To be used for hint display
    var gameImage = UIImage()
    // Container of Sliced Images sent over from FramingVC
    var slicedImages = [UIImage]()
    // Point used for comparision in moveTile to pan the image on screen
    var tileStartingPoint = CGPoint()
    // Container to hold All tiles created - to be used to get positions of tiles from / checking for game completion
    var tileContainer = [Tile]()
    // Container to store the positions of all tiles in use
    var tilePositions = [CGPoint]()
    // Container to store grid positions
    var gridPositions = [CGPoint]()
    
    
    // :: Outlets ::
    // Eye Image to display Hint Image
    @IBOutlet weak var hintButton: UIImageView!
    // Outlet to contain subviews of the inital tile grid 
    @IBOutlet var initalTileGrid: [UIView]!
    // view tp act as grid 
    @IBOutlet weak var gridView: UIView!
    // Label to display game mode
    @IBOutlet weak var modeLabel: UILabel!
    // label to display game mode value - time left / moves made 
    @IBOutlet weak var modeLabelValue: UILabel!
    
    
    
    
    
    
    // :: Buttons ::
    // New Game button - Cancel, go back to HomeVC
    @IBAction func newGamePressed(_ sender: Any) {
        print("\no<-X newGamePressed()")
        
        // remove current game image
        
    }
    
    // Func to display hint image
    @objc func showHint(_ sender: UITapGestureRecognizer) {
        print("\n ^%^ Show Hint\n")
        
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
        
    }
    
    // Create Tiles and add tiles to inital Grid
     func createTiles(from array: [UIImage]) {
        print("\n  -#- Begin Adding Tiles -#-  \n")
        
        let lowInt = 1
        let maxInt = 16
        
        // using closed range for image selection
        let closedRange = lowInt...maxInt
        
        for x in closedRange {
            
            // select image for tile
            let image = array[x - lowInt]
            
            // get a shuffled point from slicing.tileLocations
            let shuffledPoint = distributor.shuffledTileLocation()
            
            // tile frame
            let tileFrame = CGRect(x: shuffledPoint!.x, y: shuffledPoint!.y, width: distributor.tileSize, height: distributor.tileSize)
            
            // initalizing tile
            let tile = Tile(originalTileLocation: shuffledPoint!, correctPosition: (x - 1), frame: tileFrame)
            
            // add to container to then later be checked for gameCompletion
            tileContainer.append(tile)
            
            // not in correct space by defualt
            tile.isInCorrectPosition = false
            
            // adding tile image
            tile.image = image
            
            print("tile[\(x - 1)], origin = (x: \(shuffledPoint!.x), y: \(shuffledPoint!.y))\n")
            
              // add subview/gestures
              tile.isUserInteractionEnabled = true
              self.view.addSubview(tile)
              self.view.bringSubviewToFront(tile)
              addPanGestureTo(view: tile)

        }
        
        print("  -#- Finished Adding Tiles -#-  \n")
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
    
    // Can Update this to use switch statment instead
    // function to handle moving tiles & dropping tiles onto each grid
    @objc func moveTile(_ gesture: UIPanGestureRecognizer) {
        
        let tile = gesture.view as! Tile
        
        // bring selected tile to top layer
        self.view.bringSubviewToFront(tile)
        
        // add shadow to selected tile
        tile.layer.shadowOffset = CGSize(width: 0, height: 8)
        tile.layer.shadowOpacity = 0.25
        tile.layer.shadowRadius = 8
        
        // :: Movement Position ::
        // user tile movement as CGPoint
        let translation = gesture.translation(in: tile)
        // point used to get position of the tile
        let currentTilePosition = tile.frame.origin
        
        // where the user is dragging the tile to currently
        let userTargetMovementArea = CGPoint(x: (translation.x + (tileStartingPoint.x - currentTilePosition.x)), y: (translation.y + (tileStartingPoint.y - currentTilePosition.y)) )
        // move tile to movement area
        tile.transform = tile.transform.translatedBy(x: userTargetMovementArea.x, y: userTargetMovementArea.y)
        
        // :: Handle Dropped Position ::
        // recognize position in superview
        let positionInSuperview = gesture.view?.convert(userTargetMovementArea, to: gesture.view?.superview)
        
        // Check if tile is over game grid
        let (nearGameGrid, snapToGridLocation) = grid.isTileNear(grid: gridView, finalPosition: positionInSuperview!, positions: gridPositions)
        
        // Check if tile is over inital tile grid
        let (nearOriginalGrid, snapToLocation) = grid.isNearTileBay(finalPosition: positionInSuperview!, positions: tilePositions)
        
        
        switch gesture.state {
            
        case .began :
            
            // Setting tiles position to currentTilePosition
            tileStartingPoint = currentTilePosition
            print("movingTile")
            
        case .ended :
            print("\n o stoppedMoving\n")
            
            // Set tile position to incorrect by default
            tile.isInCorrectPosition = false
            
            // check if near game grid
            if nearGameGrid == true {
                
                // Drop into grid position
                print("\ndropped in snapPosition[\(snapToGridLocation)]\n")
                // Bring tile to snap position - resize tile
                UIView.animate(withDuration: 0.1, animations: {
                    // bringing tile to closest tile && scaling it to the size of the grid
                    tile.frame = CGRect(origin: self.gridPositions[snapToGridLocation], size: CGSize(width: 87.5, height: 87.5))
                    // Remove shadow
                    tile.layer.shadowOpacity = 0
                })
            }
            
            // check if near tile bay - inital tile grid
            if nearOriginalGrid == true {
                print("\n - near original grid")
                
                tile.isInCorrectPosition = false
                
                // Drop into position
                
                print("dropped in inital grid\n")
                
                tile.isInCorrectPosition = false
                
                UIView.animate(withDuration: 0.1, animations: {
                    // bringing tile to closest tile && scaling it to the size of the grid
                    tile.frame = CGRect(origin: self.tilePositions[snapToLocation], size: CGSize(width: 54, height: 54))
                    // Remove shadow
                    tile.layer.shadowOpacity = 0
                })
                
                
            }
            
            if nearGameGrid == false  {
                
                // Drop into originalTileLocation
                
                print("\nDropped Out of Bounds - back to original pos\noriginalPos = (x: \(tile.originalTileLocation!.x), y: \(tile.originalTileLocation!.y)) \n")
                UIView.animate(withDuration: 0.1 , animations: {
                    // changes view position and size - does not place tile in original location without second tile position declaration
                    tile.frame = CGRect(origin: tile.originalTileLocation!, size: CGSize(width: 54, height: 54))
                    tile.frame.origin = tile.originalTileLocation!
                    // Remove shadow
                    tile.layer.shadowOpacity = 0
                })
                
                
            }
            
            // :: if tile is in correct location ::
            if tile.correctPosition == snapToGridLocation {
                print("\n -- CORRECT POSITION -- n")
                
                tile.isInCorrectPosition = true
                
            }
            
            
            // Check if all tiles are in correct position
            manager.checkForCompletion(tileContainer)
            
            default:
            print("Gesture Recognized")
            
            
        }
        
        
        
    }
    
    // func to easily add gestures to each tile
    func addPanGestureTo(view: UIImageView) {
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(moveTile(_:)))
        view.addGestureRecognizer(panGes)
        panGes.delegate = self
        view.isUserInteractionEnabled = true
    }
    
    
    
    // :: View Configuration ::
    // func to control tile distribution
    func handleTileCreation() {
        // getting positions for tile distribution
        distributor.getSubviewPositions(from: initalTileGrid)
        // creating tiles & adding tiles to initalGrid
        createTiles(from: slicedImages)
    }
    func configurePlayfield() {
        // adding tap gesture to hint button
        addTapGesture()
        // adding tiles to playfield
        handleTileCreation()
        
        // Getting inital grid tile cordinates to allow tile placement
        tilePositions = grid.getInitalGridPositions(from: tileContainer)
        // creating grid locations to allow tile placement
        gridPositions = grid.createGridLocations(in: gridView)
    }
    
    
    func updateMode() {
        switch mode {
        case .moves:
            print("moves mode")
            // display labels
            modeLabel.text = "moves:"
            modeLabelValue.text = "00"
           
            
            // add timer to count time elapsed
            
        case .timed:
            print("timed mode")
            // display labels
            modeLabel.text = "time:"
            modeLabelValue.text = "5:00"
            
            
            // add timer to count down from timeValue
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configurePlayfield()
        
        // Do any additional setup after loading the view.
        
        updateMode()
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
