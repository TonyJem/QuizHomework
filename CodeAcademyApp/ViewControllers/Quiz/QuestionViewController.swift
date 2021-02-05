import UIKit

class QuestionViewController: CodeAcademyViewController {
    
    // MARK: - UI Components

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var fourthChoiceButton: UIButton!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    private let quizTimer = QuizTimer()
    var timerTimeInterval: Double = 10
    
    // MARK: - Button actions

    @IBAction func choiceButtonTapped(_ sender: UIButton) {
        guard  let answer = sender.titleLabel?.text else { return }
        QuizManager.checkTheAnswer(answer: answer)
        
        updateQuiz()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        quizTimer.delegate = self
        startQuiz()
    }
    
    //MARK: - Alerts
    
    lazy var timesUpAlert: AlertView? = {
        let timesUpAlert = alert
        
        timesUpAlert?.configureView(
            title: "Times up!",
            message: "Do you need more time?",
            cancelButtonTitle: "No",
            agreeButtonTitle: "Yes"
        ) { alert, button in
            if button == alert.agreeButton {
                print("Agree button was pressed")
            } else {
                print("Cancel button was pressed")
            }
        }
        return timesUpAlert
    }()
    
    lazy var gameOverAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "Game Over!",
            message: "Total points: \(QuizManager.quizState.points)",
            preferredStyle: .alert
        )

        let alertButton = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(alertButton)
        return alert
    }()
}

// MARK: - QuizTimerDelegate methods

extension QuestionViewController: QuizTimerDelegate {

    func quizTimerDidFire(_ quizTimer: QuizTimer) {
        guard let timesUpAlert = timesUpAlert else {
            updateQuiz()
            return
        }
        view.addSubview(timesUpAlert)
    }
    
    func quizTimerTimeInterval() -> Double {
        return timerTimeInterval
    }
}

// MARK: - Helpers

private extension QuestionViewController {
    
    func updateView(question: Question) {
        questionLabel.text = question.questionDescription
        firstChoiceButton.setTitle(question.firstAnswer, for: .normal)
        secondChoiceButton.setTitle(question.secondAnswer, for: .normal)
        thirdChoiceButton.setTitle(question.thirdAnswer, for: .normal)
        fourthChoiceButton.setTitle(question.fourthAnswer, for: .normal)
        questionNumberLabel.text = "\(QuizManager.quizState.currentQuestionIndex + 1)"
        updateScore()
        
    }
    
    func updateScore() {
        pointsLabel.text = "Points: \(QuizManager.quizState.points)"
    }
}

// MARK: - Quiz Functionality

private extension QuestionViewController {
    
    func startQuiz() {
        quizTimer.start()
        UserDefaultsManager.shuffleQuestions()
        guard let firstQuestion = QuizManager.firstQuizQuestion else {
            return
        }
        updateView(question: firstQuestion)
    }
    
    func updateQuiz() {
        guard let question = QuizManager.nextQuizQuestion else {
            updateScore()
            QuizManager.save()
            present(gameOverAlert, animated: true, completion: nil)
            return
        }
        updateView(question: question)
        quizTimer.reset()
    }
}

// MARK: - AlertViewDelegate methods

extension QuestionViewController: AlertViewDelegate {

    func didTapAgreeButton(alertView: AlertView, button: UIButton) {
        
    }

    func didTapCancelButton(alertView: AlertView, button: UIButton) {
        
    }
}
