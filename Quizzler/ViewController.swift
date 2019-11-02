//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestion = QuestionBank()
    var pickedAnswer:Bool = false
    var questionNumber:Int = 0
    var score = 0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstQuestion = allQuestion.list[questionNumber]
        questionLabel.text = firstQuestion.questionText
        progressLabel.text = "\(questionNumber + 1 )/13"
    }


    @IBAction func answerPressed(_ sender: AnyObject) {

        if sender.tag == 1 {
            pickedAnswer = true
        }
        checkAnswer()
        
        questionNumber += 1
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
        scoreLabel.text = "\(score)"
        if questionNumber <= 13 {
            progressLabel.text = "\(questionNumber )/13"
            progressBar.frame.size.width = (view.frame.size.width / 13 ) * CGFloat(questionNumber)
        }
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            let firstQuestion = allQuestion.list[questionNumber]
            questionLabel.text = firstQuestion.questionText

        } else {
            progressLabel.text = "13/13"
            let alert = UIAlertController(title: "Awesome", message: "Congratulations on completetion of the Quiz", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
                self.updateUI()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        if questionNumber <= 12 {
            let answer = allQuestion.list[questionNumber].answer
            
            if answer == pickedAnswer {
                ProgressHUD.showSuccess("Correct")
                score += 100
            } else {
                ProgressHUD.showError("Wrong")
            }

        }
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
        progressLabel.text = "1/13"
    }
    
}
