import UIKit

class RegisterViewController: CodeAcademyViewController {

    @IBOutlet private weak var usernameTextField: ClearableTextField!
    @IBOutlet private weak var passwordTextField: ClearableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        usernameTextField.text = nil
        passwordTextField.text = nil
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
