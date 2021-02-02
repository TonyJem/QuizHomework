//
//  QuizSettingsViewController.swift
//  CodeAcademyApp
//
//  Created by Arnas Sleivys on 2021-01-25.
//

import UIKit

final class QuizSettingsViewController: UIViewController {

    private let MinimumQuestions: Double = 1
    
    @IBOutlet weak var minQuestionsLabel: UILabel!
    @IBOutlet weak var maxQuestionsLabel: UILabel!
    @IBOutlet weak var timerSettingsLabel: UILabel!
    @IBOutlet weak var minQuestionsStepper: UIStepper!
    @IBOutlet weak var maxQuestionsStepper: UIStepper!
    @IBOutlet weak var timerSlider: UISlider!
    @IBOutlet weak var correctAnswerPointsTextField: ClearableTextField!
    @IBOutlet weak var wrongAnswerPoints: ClearableTextField!
    @IBOutlet weak var penaltyPointsTextField: ClearableTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    
    @IBAction func minQuestionsStepperValueChanged(_ sender: UIStepper) {
        minQuestionsLabel.text = "Min q: \(sender.value)"
    }
    
    @IBAction func maxQuestionsStepperValueChanged(_ sender: UIStepper) {
        maxQuestionsLabel.text = "Max q: \(sender.value)"
    }
    
    @IBAction func timmerSettingSliderValueChanged(_ sender: UISlider) {
        timerSettingsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
}

// MARK: - Helper Functions

extension QuizSettingsViewController {
    
    func configureView() {
        minQuestionsStepper.minimumValue = 1
        minQuestionsStepper.maximumValue = 10
        minQuestionsStepper.stepValue = 1
        maxQuestionsStepper.minimumValue = 1
        maxQuestionsStepper.maximumValue = 10
        maxQuestionsStepper.stepValue = 1
        timerSlider.minimumValue = 5
        timerSlider.maximumValue = 60
        timerSlider.value = timerSlider.minimumValue
    }
    
}
