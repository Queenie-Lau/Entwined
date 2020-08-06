//
//  ChooseLevel.swift
//  Entwined
//
//  Created by Queenie Lau on 8/5/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit

class ChooseLevel: UIViewController {
    @IBAction func buttonOne(_ sender: Any) {
        print("Level One: I was pressed!")
        var levelOne = true
    }
    
    @IBAction func buttonTwo(_ sender: Any) {
        print("Level Two: I was pressed!")
        var levelTwo = true
    }
    
    @IBAction func buttonThree(_ sender: Any) {
        print("Level Three: I was pressed!")
        var levelThree = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//        buttonOne.tag=1
//        buttonOne.addTarget(self,action:#selector(buttonClicked),
//                          for:.touchUpInside)
//        Button2.tag=2
//        Button2.addTarget(self,action:#selector(buttonClicked),
//                          for:.touchUpInside)
//        Button3.tag=3
//        Button3.addTarget(self,action:#selector(buttonClicked),
//                          for:.touchUpInside)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


