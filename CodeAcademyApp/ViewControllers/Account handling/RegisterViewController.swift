import UIKit

class RegisterViewController: CodeAcademyViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        do {
            try AccountManager.registerAccount(username: usernameTextField.text, password: passwordTextField.text)
            proceedToQuizView()
        } catch {
            if let error = error as? AccountManager.AccountManagerError {
                showFailureAlert(message: error.errorDescription)
            }
        }
    }
}
