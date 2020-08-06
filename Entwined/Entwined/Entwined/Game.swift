//
//  Game.swift
//  Entwined
//
//  Created by Queenie Lau on 8/4/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit
import Lottie
import CoreMotion

class Game: UIViewController {
    // Get the level that the user chose
    
    @IBAction func levelOne(_ sender: Any) {
        print("Level One was clicked")
    }
    
    
    @IBAction func levelTwo(_ sender: Any) {
        print("Level Two was clicked")
    }
    
    
    @IBAction func levelThree(_ sender: Any) {
        print("Level Three was cliked")
    }
    
    
    // Start tracking the device's motion
    let motion = CMMotionManager()
    
    @IBOutlet weak var xGyro: UITextField!
    static var animationPlayed = false
    @IBOutlet weak var animationView: AnimationView!
    var orientations = UIInterfaceOrientationMask.landscape
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    get { return self.orientations }
    set { self.orientations = newValue }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if(Game.animationPlayed == false){
            lottieAnimation()
        }

        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        var screenWidth = screenSize.width
        var screenHeight = screenSize.height
        var temp = screenHeight
        print(screenWidth)
        print(screenHeight)
        if(screenWidth > screenHeight){
            temp = screenHeight
            screenHeight = screenWidth
            screenWidth = temp
        }
        let yourView = UIView(frame: CGRect(x: 0, y: 0, width: screenHeight, height: screenWidth))
        yourView.layer.borderWidth = 10
        yourView.layer.cornerRadius = 40
        yourView.layer.borderColor = UIColor(red:233/255, green:247/255, blue:171/255, alpha: 1).cgColor
        view.insertSubview(yourView, at: 0)
        myGyroscope()
    }

    func lottieAnimation(){
        
         let countdown = Animation.named("countdown")
         let lottieView = AnimationView(animation: countdown)

         self.view.addSubview(lottieView)
         lottieView.contentMode = .scaleAspectFit
         lottieView.play(toFrame: .infinity)

         lottieView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             lottieView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
             lottieView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
             lottieView.topAnchor.constraint(equalTo: self.view.topAnchor),
             lottieView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
         ])
        view.sendSubviewToBack(lottieView)
        Game.animationPlayed = true
    }
    
    func myGyroscope() {
        motion.gyroUpdateInterval = 0.5
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in (data as Any)
            if let trueData = data {
                self.view.reloadInputViews()
                 let b = trueData.attitude.roll
                print(b.rounded(toPlaces: 3))
            }
        }
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

func radiansToDegrees(_ radians: Double) -> Double {
    return radians * (180.0 / Double.pi)
}

class HeadsUp {
    var gameOver = false
    var seenWords:[String] = []
    var correctWords:[String] = []
    var inccorectWords:[String] = []
    
    
    let levelOneWords = ["Recycle", "Water", "Pollution", "Planet", "Environment", "Energy", "Electricity", "Plant", "Flower", "Sustainable", "Sunlight", "Rain", "Ocean", "Heat", "Coral"]

    let levelTwoWords = ["Renewable energy", "Solor energy", "Wind power", "Biomass", "Hydrogen", "Geothermal", "Marine animal", "Estuary", "Coral reef", "Hydroelectric", "Fossil fuel", "Power plant", "Agriculture", "Mining", "Climate change"]

    let levelThreeWords = ["Envrionmental degradation", "Organic farming", "Phytoplankton", "Sustainable gardening", "Industrial revolution", "Great Pacific Garbage Patch", "Marine debris", "Cross contamination", "Atmospheric circulation", "Ocean circulation", "Greenhouse gases", "Photosynthesis", "Ecosystem", "Marine invertebrate", "Conservation practices"]

    func getLevelOneWord() -> String {
        var duplicateArray = levelOneWords
        let randomWord = levelOneWords.randomElement()!
        seenWords.append(randomWord)
        if let index = duplicateArray.firstIndex(of: randomWord) {
            duplicateArray.remove(at: index)
        }
        return randomWord
    }
    
}
