//
//  QuizHomeViewController.swift
//  CodeAcademyApp
//
//  Created by Arnas Sleivys on 2020-12-28.
//

import UIKit

class QuizHomeViewController: CodeAcademyViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var addQuestionsButton: UIButton!
    @IBOutlet weak var pointsForCorrectLabel: UILabel!
    @IBOutlet weak var pointsMinusWhenWrongLabel: UILabel!
    @IBOutlet weak var pointsPenaltyWhenMoreTimeLabel: UILabel!
    
    @IBAction func beginButtonPressed(_ sender: Any) {
        proceedToQuestionView()
    }

    @IBAction func settingsButtonPressed() {
        proceedToSettingsView()
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func addQuestionsPressed(_ sender: Any) {
        proceedToAddQuestionView()
    }

    @IBAction func leaderboardButtonPressed(_ sender: Any) {
        proceedToLeaderboardView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPointsRulesLabels()
    }

    private func configureView() {
        if let loggedInAccount = AccountManager.loggedInAccount {
            welcomeLabel.text = "Welcome to the quiz, " + loggedInAccount.username
            addQuestionsButton.isHidden = loggedInAccount.accountType == .user
        }
    }
    
    func loadPointsRulesLabels() {
        pointsForCorrectLabel.text = "Points for correct answer: \(QuizManager.pointsRules.correctAnswer)"
        pointsMinusWhenWrongLabel.text = "Points minus when wrong answer: \(QuizManager.pointsRules.wrongAnswer)"
        pointsPenaltyWhenMoreTimeLabel.text = "Penalty points when more time asked: \(QuizManager.pointsRules.timePenalty)"
    }
}