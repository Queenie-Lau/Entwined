//
//  ResultsViewController.swift
//  Entwined
//
//  Created by Queenie Lau on 8/6/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var orientations = UIInterfaceOrientationMask.portrait
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    get { return self.orientations }
    set { self.orientations = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
