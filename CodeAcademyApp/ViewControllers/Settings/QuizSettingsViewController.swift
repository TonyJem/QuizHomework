import UIKit

final class QuizSettingsViewController: CodeAcademyViewController {

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
    @IBOutlet weak var addQuestionsButton: UIButton!
    @IBOutlet private weak var deleteAllQuestions: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    
    @IBAction func minQuestionsStepperValueChanged(_ sender: UIStepper) {
        minQuestionsLabel.text = "Min q: \(Int(sender.value))"
        SystemDefaults.minimalQuestionQuantity = Int(sender.value)
    }
    
    @IBAction func maxQuestionsStepperValueChanged(_ sender: UIStepper) {
        maxQuestionsLabel.text = "Max q: \(Int(sender.value))"
    }
    
    @IBAction func timmerSettingSliderValueChanged(_ sender: UISlider) {
        timerSettingsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func addQuestionsTapped(_ sender: UIButton) {
        proceedToAddQuestionView()
    }
    
    @IBAction func deleteAllQuestionsTapped(_ sender: UIButton) {
        callDeleteAllQuestionAlert()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
}

// MARK: - Helper Functions

extension QuizSettingsViewController {
    
    private func setLabels() {
        minQuestionsLabel.text = "Min q: \(SystemDefaults.minimalQuestionQuantity)"
    }
    
    func configureView() {
        setLabels()
        minQuestionsStepper.minimumValue = 1
        minQuestionsStepper.maximumValue = 10
        minQuestionsStepper.stepValue = 1
        maxQuestionsStepper.minimumValue = 1
        maxQuestionsStepper.maximumValue = 10
        maxQuestionsStepper.stepValue = 1
        timerSlider.minimumValue = 5
        timerSlider.maximumValue = 60
        timerSlider.value = timerSlider.minimumValue
        
        if let loggedInAccount = AccountManager.loggedInAccount {
            let adminIsConnected = loggedInAccount.accountType == .admin
            addQuestionsButton.isHidden = !adminIsConnected
            deleteAllQuestions.isHidden = !adminIsConnected
        }
    }
    
    private func callDeleteAllQuestionAlert() {
        // create the alert
        let alert = UIAlertController(
            title: "All questions are about to delete !!!",
            message: "Are you sure you want to delete them all?",
            preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {_ in
            UserDefaultsManager.deleteAllQuestions()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
