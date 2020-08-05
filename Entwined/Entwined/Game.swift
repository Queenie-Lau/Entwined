//
//  Game.swift
//  Entwined
//
//  Created by Queenie Lau on 8/4/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit

class Game: UIViewController {
    
    var orientations = UIInterfaceOrientationMask.landscape //or what orientation you want
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    get { return self.orientations }
    set { self.orientations = newValue }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let yourView = UIView(frame: CGRect(x: 0, y: 0, width: screenHeight, height: screenWidth))
        yourView.layer.borderWidth = 10
        yourView.layer.cornerRadius = 40
        yourView.layer.borderColor = UIColor(red:233/255, green:247/255, blue:171/255, alpha: 1).cgColor
        view.addSubview(yourView)
     
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
