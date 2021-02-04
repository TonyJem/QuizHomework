import UIKit

class CodeAcademyViewController: UIViewController {

    typealias VoidCompletion = () -> Void

    private let AlertButtonTitle = "OK"
    private let FailureAlertTitle = "Oops!"

    // MARK: - UIViewControllers

    private lazy var QuizHomeStoryboard: UIStoryboard = {
        UIStoryboard(name: "QuizHome", bundle: nil)
    }()

    private lazy var SettingsStoryboard = {
        UIStoryboard(name: "Settings", bundle: nil)
    }()

    private var QuizHomeViewController: UIViewController {
        QuizHomeStoryboard.instantiateViewController(identifier: "QuizHomeViewController")
    }

    private var QuestionViewController: UIViewController {
        QuizHomeStoryboard.instantiateViewController(identifier: "QuestionViewController")
    }

    private var AddQuestionViewController: UIViewController {
        SettingsStoryboard.instantiateViewController(identifier: "AddQuestionViewController")
    }
    
    private var PointsRulesViewController: UIViewController {
        QuizHomeStoryboard.instantiateViewController(identifier: "PointsRulesViewController")
    }

    private var LeaderboardTableViewController: UITableViewController {
        QuizHomeStoryboard.instantiateViewController(identifier: "LeaderboardViewController")
    }

    private var SettingsViewController: UIViewController {
        SettingsStoryboard.instantiateViewController(withIdentifier: "SettingsViewController")
    }

    // MARK: - Alert functionality

    lazy var alert = {
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)?.first as? AlertView
    }()

    func showFailureAlert(message: String, animated: Bool = true) {
        guard let failureAlert = alert else {
            return
        }
        failureAlert.configureView(
            title: FailureAlertTitle,
            message: message,
            agreeButtonTitle: "OK"
        )
        view.addSubview(failureAlert)
    }
}

// MARK: - Transitions

extension CodeAcademyViewController {

    func proceedToQuizView() {
        modalPresentationStyle = .fullScreen
        present(QuizHomeViewController, animated: true)
    }

    func proceedToQuestionView() {
        modalPresentationStyle = .automatic
        present(QuestionViewController, animated: true)
    }

    func proceedToAddQuestionView() {
        modalPresentationStyle = .automatic
        present(AddQuestionViewController, animated: true)
    }
    
    func proceedToSetPointsRulesView() {
        modalPresentationStyle = .automatic
        present(PointsRulesViewController, animated: true)
    }

    func proceedToLeaderboardView() {
        modalPresentationStyle = .automatic
        present(LeaderboardTableViewController, animated: true)
    }

    func proceedToSettingsView() {
        modalPresentationStyle = .fullScreen
        present(SettingsViewController, animated: true)
    }
}

// MARK: - UITextFieldDelegate methods

extension CodeAcademyViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
