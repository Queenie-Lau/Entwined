//
//  Game.swift
//  Entwined
//
//  Created by Queenie Lau on 8/4/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit
import Lottie

class Game: UIViewController {
    
//    @IBAction func workPlease(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "FirstCard", sender: self)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.performSegue(withIdentifier: "FirstCard", sender: self)
//        }
      
//        print("went inside here")
//    }
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
    }
//    override func viewDidAppear(_ animated: Bool) {
//          func performSegue(withIdentifier: String, sender: Any?){
//                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                     performSegue(withIdentifier: "FirstCard", sender: self)
//                 }
//             }
//    }
    
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
    
}
