//
//  ViewController.swift
//  Entwined
//
//  Created by Queenie Lau on 7/29/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var askButton: UIButton!
    @IBOutlet weak var questionField: UITextField!
    let answerToQuestion = QuestionsAndAnswers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lottieAnimation()
        if(questionField != nil){
            questionField.becomeFirstResponder()
        }
    }
    
    func lottieAnimation(){
        
        let animationView = AnimationView(name: "tester-again")
        animationView.frame = CGRect(x:0, y: 0, width: 400, height: 700)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .autoReverse;
        // Loop animation
    
    }
    
    // Create Environmental Chat Bot
    func respondToQuestion(_ inputQuestion: String) {
        let answer = answerToQuestion.responseTo(question: inputQuestion)
            displayAnswerTextOnScreen(answer)
            questionField.placeholder = "Ask another question..."
            questionField.text = nil
            askButton.isEnabled = false
    }

    @IBAction func askButtonTapped(_ sender: AnyObject) {
        guard questionField.text != nil else {
            return
        }
        questionField.resignFirstResponder()
    }
    
    func displayAnswerTextOnScreen(_ answer: String) {
        responseLabel.text = answer
    }

}

    extension ViewController: UITextFieldDelegate {

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            guard let text = textField.text else {
                return
            }
            
            respondToQuestion(text)
        }
        
        @IBAction func editingChanged(_ textField: UITextField) {
            guard let text = textField.text else {
                askButton.isEnabled = false
                return
            }
            
            askButton.isEnabled = !text.isEmpty
        }

}


