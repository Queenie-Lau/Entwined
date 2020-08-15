//
//  ViewController.swift
//  Entwined
//
//  Created by Queenie Lau on 7/29/20.
//  Copyright © 2020 Queenie Lau. All rights reserved.
//
import ARKit
import UIKit
import Lottie
var animationPlayedAlready = false

class ViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var askButton: UIButton!
    @IBOutlet weak var questionField: UITextField!
    
    
    
    
    // Add Cube in AR
    @IBAction func addCube(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        self.sceneView.autoenablesDefaultLighting = true
        let x = randomNumbers(firstNum: 0.3, secondNum: -0.3)
        let y = randomNumbers(firstNum: 0.3, secondNum: -0.3)
        let z = randomNumbers(firstNum: 0.3, secondNum: -0.3)
        node.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
         return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
        
    }
    // Add AR Scene View
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    
    
    let answerToQuestion = QuestionsAndAnswers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(animationPlayedAlready == false){
            lottieAnimation()
            animationPlayedAlready = true;
        }
        if(questionField != nil){
            questionField.becomeFirstResponder()
        }
        // Look at feature points
        if(self.sceneView != nil){
            self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
             // Start AR view
             self.sceneView.session.run(configuration)
            // Below is testingif the AR breaks
//            print(ARSCNDebugOptions.showWorldOrigin)
//            self.sceneView.session.run(configuration)
        }
    }
    
    func lottieAnimation(){
        let animationView = AnimationView(name: "tester-again")
        animationView.frame = CGRect(x:-30, y: -800, width: 400, height: 700)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        if(animationPlayedAlready == false){
            animationView.play()
            animationView.loopMode = .autoReverse
         //   animationView.loopMode = .loop
            
        }
        if(self.animationView != nil){
                self.animationView.layer.removeAllAnimations()
                self.view.layer.removeAllAnimations()
                self.view.layoutIfNeeded()
            }
        
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


