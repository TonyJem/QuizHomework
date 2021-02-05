import UIKit

class QuizHomeViewController: CodeAcademyViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var pointsForCorrectLabel: UILabel!
    @IBOutlet weak var pointsMinusWhenWrongLabel: UILabel!
    @IBOutlet weak var pointsPenaltyWhenMoreTimeLabel: UILabel!
    
    @IBAction func beginButtonPressed(_ sender: Any) {
        beginQuizIfEnoughtQuestions()
    }

    @IBAction func settingsButtonPressed() {
        proceedToSettingsView()
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func leaderboardButtonPressed(_ sender: Any) {
        guard !LeaderboardManager.scoreRows.isEmpty else {
            callLeaderboardIsEmptyAlert()
            return
        }
        proceedToLeaderboardView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPointsRulesLabels()
    }
    
    private func callLeaderboardIsEmptyAlert() {
        // create the alert
        let alert = UIAlertController(
            title: "The Leaderboard is currently empty !!!",
            message: "Just go ahead and complete one Quiz at least",
            preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    private func configureView() {
        if let loggedInAccount = AccountManager.loggedInAccount {
            welcomeLabel.text = "Welcome to the quiz, " + loggedInAccount.username
        }
    }
    
    func loadPointsRulesLabels() {
        pointsForCorrectLabel.text = "Points for correct answer: \(QuizManager.pointsRules.correctAnswer)"
        pointsMinusWhenWrongLabel.text = "Points minus when wrong answer: \(QuizManager.pointsRules.wrongAnswer)"
        pointsPenaltyWhenMoreTimeLabel.text = "Penalty points when more time asked: \(QuizManager.pointsRules.timePenalty)"
    }
}

extension QuizHomeViewController {
    
    private func beginQuizIfEnoughtQuestions() {
        guard let questions = UserDefaultsManager.questions else { return }
        
        guard !questions.isEmpty else {
            callNoQuestionsSavedAlert()
            return
        }
        
        guard SystemDefaults.minimalQuestionQuantity <= questions.count else {
            callNotEnoughtQuestionsAlert()
            return
        }
        proceedToQuestionView()
    }
    
    private func callNoQuestionsSavedAlert() {
        let alert = UIAlertController(
            title: "Can't start Quiz!!!",
            message: "There are not enought questions ! \nPlease add at least one question and try start Quiz again",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func callNotEnoughtQuestionsAlert() {
        let alert = UIAlertController(
            title: "Can't start Quiz!!!",
            message: "There are not enought questions !\nPlease add more questions or reduce minimal amount of questions in Quiz settings",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
