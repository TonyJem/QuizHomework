//
//  PointsRulesViewController.swift
//  CodeAcademyApp
//
//  Created by Arnas Sleivys on 2020-12-28.
//

import UIKit

class PointsRulesViewController: CodeAcademyViewController {
    
    // MARK: - UI Components

    @IBOutlet weak var pointsForCorrectAnswerTextField: UITextField!
    @IBOutlet weak var pointsForWrongAnswerTextField: UITextField!
    @IBOutlet weak var pointsForExtraTimePenaltyTextField: UITextField!
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if pointsSetSucessfully() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func pointsSetSucessfully() -> Bool {
        guard
            let pointsForCorrectString = pointsForCorrectAnswerTextField.text,
            let pointsForWrongString = pointsForWrongAnswerTextField.text,
            let pointsPenaltyString = pointsForExtraTimePenaltyTextField.text,
            let pointsForCorrect = Int(pointsForCorrectString),
            let pointsForWrong = Int(pointsForWrongString),
            let pointsPenalty = Int(pointsPenaltyString)
        else {
            return false
        }
        
        UserDefaultsManager.pointsRules = Points(
            correctAnswer: pointsForCorrect,
            wrongAnswer: pointsForWrong,
            timePenalty: pointsPenalty
        )
        return true
    }
    
}
