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

    @IBAction func correctGuess(_ sender: Any) {
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 40
    var timer = Timer()
    var timerIsOn = false
    var currLevel = -1
    static var finishedGame = false
    static var threeSecTimerPlayedOnce = false
    static var fourtySecTimerPlayedOnce = false
    static var levelOneDone = false
    static var levelTwoDone = false
    static var levelThreeDone = false
    
    @IBOutlet weak var word: UILabel!
    
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
    
//    override func viewDidAppear(_ animated: Bool) {
//         performSegue(withIdentifier: "Results", sender: self)
//    }
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
//        myGyroscope()
        
        DispatchQueue.main.async {
            if(self.word != nil){
                if (ChooseLevel.getLevel.levelOne == true){
                   print("I went inside")
                   self.word.text = getLevelOneWord()
                   self.word.center = self.view.center
                   var currLevel = 1
                }
                else if (ChooseLevel.getLevel.levelTwo == true) {
                    self.word.text =  getLevelTwoWord()
                    self.word.center = self.view.center
                    var currLevel = 2
                }
                else {
                    self.word.text =  getLevelThreeWord()
                    self.word.center = self.view.center
                    var currLevel = 3
                }
            }
            
        }
        if(Game.finishedGame == false){
            // Add timer
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
            
            // Add timer to see if it is time to show results
            let fourtySeconds = Timer.scheduledTimer(timeInterval: 40.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
            
            
            // Transition to game screen after 3 seconds
            let threeSeconds = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        }
        // Get gesture
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(Game.handleSwipe))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(Game.handleSwipe))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
      
        /** TODO
        // Check if timer is 0 or if we are out of words
        if(seconds == 0 || Game.levelOneDone || Game.levelTwoDone || Game.levelThreeDone){
            // Show the results screen
           timeToMoveOn()
        }
        */
    }
    
    
    @objc func timeToMoveOn() {
            print("Transition to results")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Game", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Results")
            self.present(newViewController, animated: true, completion: nil)
            Game.finishedGame = true
        
       }
    
    @objc func playGame() {
             print("Game starts now!")
            if(Game.threeSecTimerPlayedOnce == false){
                 let storyBoard: UIStoryboard = UIStoryboard(name: "Game", bundle: nil)
                 let newViewController = storyBoard.instantiateViewController(withIdentifier: "Transition")
                 self.present(newViewController, animated: true, completion: nil)
            }
             Game.threeSecTimerPlayedOnce = true
             myGyroscope()
        }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        print("swipe direction is", sender.direction)
        // Check whether the word is correct or incorrect
        if(sender.direction == .up){
            print("correct answer")
            if(seconds > 0){
                if(currLevel == 1){
                    self.word.text = getLevelOneWord()
                    
                }
                else if(currLevel == 2){
                    self.word.text = getLevelTwoWord()
                }
                else{
                    self.word.text = getLevelThreeWord()
                }
            }
        }
        else if(sender.direction == .down){
            print("incorrect answer")
            if(seconds > 0){
                if(currLevel == 1){
                    self.word.text = getLevelOneWord()
                    
                }
                else if(currLevel == 2){
                    self.word.text = getLevelTwoWord()
                }
                else{
                    self.word.text = getLevelThreeWord()
                }
            }
        }
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
        var hasNotReturnedToNeutralState = true
        motion.gyroUpdateInterval = 0.5
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in (data as Any)
            if let trueData = data {
                if(self.seconds > 0){
                self.view.reloadInputViews()
                let rollValue = trueData.attitude.roll
                // check if word is correct or incorrect
                
                if(abs(rollValue) < 1 && self.seconds > 0){
                    if(self.word != nil){
                            print(self.word.text!)
                            incorrectWords.append(self.word.text!)
                            if(ChooseLevel.getLevel.levelOne == true){
                                 self.word.text! = getLevelOneWord()
                            }
                            else if(ChooseLevel.getLevel.levelOne == true){
                                self.word.text! = getLevelTwoWord()
                            }
                            else{
                                self.word.text! = getLevelThreeWord()
                            }
                        }
                   
                    }
                 print(abs(rollValue.rounded(toPlaces: 3)))
                
                if(abs(rollValue) >= 1 && abs(rollValue) < 2){
                    hasNotReturnedToNeutralState = false
                    }
                 }
            }
            return;
      
//
//                 else if(abs(rollValue) > 1){
//                    if(self.word != nil){
//                        if(seenWords.contains(self.word.text!) == false){
//                            correctWords.append(self.word.text!)
//                        }
//                        if(ChooseLevel.getLevel.levelOne == true){
//                             self.word.text = getLevelOneWord()
//                        }
//                        else if(ChooseLevel.getLevel.levelOne == true){
//                            self.word.text = getLevelTwoWord()
//                        }
//                        else{
//                            self.word.text = getLevelThreeWord()
//                        }
//                    }
//                 }
//                print(correctWords)
//                print(incorrectWords)
              
            }
        }
    
    // Update timer
@objc func countdown() {
        seconds -= 1
        if(timerLabel != nil){
            if(seconds >= 0){
                timerLabel.text = "\(seconds)"
            }
            else{
                // Check if they got the answer or not?
                return;
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

    // Game class

    var gameOver = false
    var seenWords:[String] = []
    var correctWords:[String] = []
    var incorrectWords:[String] = []
    
    
    let levelOneWords = ["Recycle", "Water", "Pollution", "Planet", "Environment", "Energy", "Electricity", "Plant", "Flower", "Sustainable", "Sunlight", "Rain", "Ocean", "Heat", "Coral"]

    let levelTwoWords = ["Renewable energy", "Solor energy", "Wind power", "Biomass", "Hydrogen", "Geothermal", "Marine animal", "Estuary", "Coral reef", "Hydroelectric", "Fossil fuel", "Power plant", "Agriculture", "Mining", "Climate change"]

    let levelThreeWords = ["Envrionmental degradation", "Organic farming", "Phytoplankton", "Sustainable gardening", "Industrial revolution", "Great Pacific Garbage Patch", "Marine debris", "Cross contamination", "Atmospheric circulation", "Ocean circulation", "Greenhouse gases", "Photosynthesis", "Ecosystem", "Marine invertebrate", "Conservation practices"]

    func getLevelOneWord() -> String {
        var duplicateArray = levelOneWords
        var randomWord = levelOneWords.randomElement()!
        var needNewWord = false
        if(seenWords.contains(randomWord)){
            needNewWord = true
            while(needNewWord == true){
                randomWord = levelOneWords.randomElement()!
                if(seenWords.contains(randomWord)){
                    continue
                }
                else{
                    needNewWord = false
                }
            }
        }
        seenWords.append(randomWord)
        if let index = duplicateArray.firstIndex(of: randomWord) {
            duplicateArray.remove(at: index)
        }
        // Below are testing statements
//        print(duplicateArray)
//        print(levelOneWords)
        
        // Check if we went through all the words already
        if(seenWords.count == levelOneWords.count){
            Game.levelOneDone = true
        }
//        print(Game.levelOneDone)
//        print(duplicateArray)
        return randomWord
    }

  func getLevelTwoWord() -> String {
      var duplicateArray = levelTwoWords
        var randomWord = levelTwoWords.randomElement()!
        var needNewWord = false
        if(seenWords.contains(randomWord)){
            needNewWord = true
            while(needNewWord == true){
                randomWord = levelTwoWords.randomElement()!
                if(seenWords.contains(randomWord)){
                    continue
                }
                else{
                    needNewWord = false
                }
            }
        }
        seenWords.append(randomWord)
        if let index = duplicateArray.firstIndex(of: randomWord) {
            duplicateArray.remove(at: index)
        }
        if(seenWords.count == levelTwoWords.count){
              Game.levelTwoDone = true
          }
//        print(Game.levelTwoDone)
//        print(duplicateArray)
        return randomWord
    }

func getLevelThreeWord() -> String {
   var duplicateArray = levelThreeWords
      var randomWord = levelThreeWords.randomElement()!
      var needNewWord = false
      if(seenWords.contains(randomWord)){
          needNewWord = true
          while(needNewWord == true){
              randomWord = levelThreeWords.randomElement()!
              if(seenWords.contains(randomWord)){
                  continue
              }
              else{
                  needNewWord = false
              }
          }
      }
      seenWords.append(randomWord)
      if let index = duplicateArray.firstIndex(of: randomWord) {
          duplicateArray.remove(at: index)
      }
    if(seenWords.count == levelThreeWords.count){
              Game.levelThreeDone = true
          }
//      print(Game.levelTwoDone)
//      print(duplicateArray)
      return randomWord
  }


