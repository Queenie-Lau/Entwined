//
//  PreviewViewController.swift
//  Entwined
//
//  Created by Alexandra Lai on 8/15/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    
    @IBOutlet weak var photo: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
        // Do any additional setup after loading the view.
    }

    
    @IBAction func cancelButton_TouchUpInside(_ sender: Any) {
    }
    
    @IBAction func saveButton_TouchUpInside(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
