//
//  FadeViewController.swift
//  Entwined
//
//  Created by Queenie Lau on 8/1/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit
import Hero

class FadeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func undwind(for segue: UIStoryboardSegue){

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HeroTest" {
            let dest = segue.destination as! FadeViewController
            dest.hero.isEnabled = true
            dest.hero.modalAnimationType = .selectBy(presenting: .zoomSlide(direction: .left), dismissing: .zoomSlide(direction: .right))
        }
    }


    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
