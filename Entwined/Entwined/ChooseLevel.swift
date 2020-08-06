//
//  ChooseLevel.swift
//  Entwined
//
//  Created by Queenie Lau on 8/5/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit

class ChooseLevel: UIViewController {
     // filename.structname.yourvariable
    struct getLevel {
           static var levelOne = false
           static var levelTwo = false
           static var levelThree = false
       }
    
    @IBAction func buttonOne(_ sender: Any) {
        print("Level One: I was pressed!")
        ChooseLevel.getLevel.levelOne = true
    }
    
    @IBAction func buttonTwo(_ sender: Any) {
        print("Level Two: I was pressed!")
          ChooseLevel.getLevel.levelTwo = true
    }
    
    @IBAction func buttonThree(_ sender: Any) {
        print("Level Three: I was pressed!")
         ChooseLevel.getLevel.levelThree = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

