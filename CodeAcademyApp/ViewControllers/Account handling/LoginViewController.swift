//
//  LoginViewController.swift
//  CodeAcademyApp
//
//  Created by Arnas Sleivys on 2020-12-12.
//

import UIKit

class LoginViewController: CodeAcademyViewController {

    @IBOutlet weak var usernameTextField: ClearableTextField!
    @IBOutlet weak var passwordTextField: ClearableTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.clearableTextFieldDelegate = self
        passwordTextField.clearableTextFieldDelegate = self
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        do {
            try AccountManager.login(username: usernameTextField.text, password: passwordTextField.text)
            proceedToQuizView()
        } catch {
            if let error = error as? AccountManager.AccountManagerError {
                showFailureAlert(message: error.errorDescription)
            }
        }
    }
}

// MARK: - ClearableTextFieldDelegate methods

extension LoginViewController: ClearableTextFieldDelegate {

    func didTapClearIcon(_ icon: UIImageView) {
        print("I was tapped!")
    }
}
