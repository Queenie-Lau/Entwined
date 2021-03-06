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
    
    @IBOutlet weak var levelLabel: UILabel!
    
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
    
    // Labels for each word (for the results page)
    
    @IBOutlet weak var word1: UILabel!
    @IBOutlet weak var word2: UILabel!
    @IBOutlet weak var word3: UILabel!
    @IBOutlet weak var word4: UILabel!
    @IBOutlet weak var word5: UILabel!
    @IBOutlet weak var word6: UILabel!
    @IBOutlet weak var word7: UILabel!
    @IBOutlet weak var word8: UILabel!
    @IBOutlet weak var word9: UILabel!
    @IBOutlet weak var word10: UILabel!
    @IBOutlet weak var word11: UILabel!
    @IBOutlet weak var word12: UILabel!
    @IBOutlet weak var word13: UILabel!
    @IBOutlet weak var word14: UILabel!
    @IBOutlet weak var word15: UILabel!
    
    // Charade word label
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
        
        // Check what level was chosen
        if(ChooseLevel.getLevel.levelOne == true) {
              currLevel = 1
          }
        else if(ChooseLevel.getLevel.levelTwo == true) {
            currLevel = 2
        }
        else{
            currLevel = 3
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
                }
                else if (ChooseLevel.getLevel.levelTwo == true) {
                    self.word.text =  getLevelTwoWord()
                    self.word.center = self.view.center
                }
                else {
                    self.word.text =  getLevelThreeWord()
                    self.word.center = self.view.center
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
      
    
        // Check if timer is 0 or if we are out of words
        if(seconds == 0 || Game.levelOneDone == true || Game.levelTwoDone == true || Game.levelThreeDone == true){
            // Show the results screen
           timeToMoveOn()
        }
   
        if(levelLabel != nil){
              levelLabel.text = "Level \(currLevel)"
        }
        
       // Display correct and incorrect words onto the display page
        
        let labelsArray = [word1, word2, word3, word4, word5, word6, word7, word8, word9, word10, word11, word12, word13, word14, word15]
        var incorrectWordsIndex = 0
        for (index, element) in labelsArray.enumerated() {
            if(index < correctWords.count){
                if(element != nil){
                    element!.text = correctWords[index]
                    element!.textColor = UIColor.green
                }
            }
            else{
                if(incorrectWordsIndex < incorrectWords.count){
                    if(element != nil){
                        element!.text = incorrectWords[incorrectWordsIndex]
                        element!.textColor = UIColor.red
                        incorrectWordsIndex = incorrectWordsIndex + 1
                    }
                }
            }
        }
    }

 
    @objc func timeToMoveOn() {
            print("Transition to results")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Game", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Results")
            self.present(newViewController, animated: true, completion: nil)
            Game.finishedGame = true
        
            print(incorrectWords)
            print(correctWords)
        
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
        // Check if timer is 0 or if we are out of words
             if(seconds == 0 || Game.levelOneDone == true || Game.levelTwoDone == true || Game.levelThreeDone == true){
                 // Show the results screen
                timeToMoveOn()
             }
        }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        print("swipe direction is", sender.direction)
        // Check whether the word is correct or incorrect
        if(sender.direction == .up){
            print("correct answer")
            if(seconds > 0){
                if(self.word != nil){
                    if(currLevel == 1){
                        let newWord = getLevelOneWord()
                        self.word.text = newWord
                        correctWords.append(newWord)
                        
                    }
                    else if(currLevel == 2){
                         let newWord = getLevelTwoWord()
                         self.word.text = newWord
                         correctWords.append(newWord)
                    }
                    else{
                         let newWord = getLevelThreeWord()
                         self.word.text = newWord
                        correctWords.append(newWord)
                    }
                }
            }
        }
            
        else if(sender.direction == .down){
            print("incorrect answer")
            if(seconds > 0){
                if(self.word != nil){
                    if(currLevel == 1){
                         let newWord = getLevelOneWord()
                         self.word.text = newWord
                         incorrectWords.append(newWord)
                         
                     }
                     else if(currLevel == 2){
                          let newWord = getLevelTwoWord()
                          self.word.text = newWord
                          incorrectWords.append(newWord)
                     }
                     else{
                          let newWord = getLevelThreeWord()
                          self.word.text = newWord
                         incorrectWords.append(newWord)
                    }
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
        var getNewWord = true
        var getAnotherWord = true
        motion.gyroUpdateInterval = 0.5
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in (data as Any)
            if let trueData = data {
                if(self.seconds > 0 && (Game.levelOneDone == false || Game.levelTwoDone == false || Game.levelThreeDone == false)){
                self.view.reloadInputViews()
                let rollValue = trueData.attitude.roll
                // check if word is correct or incorrect
                
                if(abs(rollValue) < 1 && getNewWord == true){
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
                    getNewWord = false
                    }

                    if(abs(rollValue) >= 1 && abs(rollValue) < 2){
                        getNewWord = true
                    }
               
                else if(abs(rollValue) > 2 && getAnotherWord == true){
                   if(self.word != nil){
                        print(self.word.text!)
                        correctWords.append(self.word.text!)
                    
                    if(ChooseLevel.getLevel.levelOne == true && Game.levelOneDone == false){
                            self.word.text = getLevelOneWord()
                       }
                    else if(ChooseLevel.getLevel.levelOne == true && Game.levelTwoDone == false){
                           self.word.text = getLevelTwoWord()
                       }
                       else{
                        if(Game.levelThreeDone == false){
                           self.word.text = getLevelThreeWord()
                        }
                       }
                    getAnotherWord = false
                   }
                }
                    
                if(abs(rollValue) >= 1 && abs(rollValue) < 2){
                    getAnotherWord = true
                }
               // Testing code to see all roll values
//              print(abs(rollValue.rounded(toPlaces: 3)))
                    
                 }
        
            }
            return;
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

    let levelTwoWords = ["Renewable energy", "Solar energy", "Wind power", "Biomass", "Hydrogen", "Geothermal", "Marine animal", "Estuary", "Coral reef", "Hydroelectric", "Fossil fuel", "Power plant", "Agriculture", "Mining", "Climate change"]

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
            print("Check if game level one is done")
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


