//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place instance variables here
    
    let allQuestions = QuestionBank ()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    var progress : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        
        nextQuestion()
        
        
    }
    
    
    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        
        progressLabel.text = "\(questionNumber + 1) / 14"
        
        progressBar.frame.size.width = (view.frame.size.width / 14) * CGFloat(questionNumber + 1)
      
    }
    

    func nextQuestion() {
        if questionNumber <= 13 {
         questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
        
        else {
            print("End of Quizz")
            
            let alert = UIAlertController(title: "Awsome", message: "You've finished all the questions, do you want to startover?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                    self.startOver()
                
            }
        
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil )
            
        }

    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            print("Right")
            ProgressHUD.showSuccess("Right")
            score = score + 1
        }
        else {
            ProgressHUD.showError("Wrong")
            print("Wrong")
        }

    }
    
    
    func startOver() {
        
        score = 0
        questionNumber = 0
        nextQuestion()
       
    }
    

    
}
