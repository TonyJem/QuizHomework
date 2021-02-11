import UIKit

final class UserSettingsViewController: UIViewController {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var usernameTextField: ClearableTextField!
    @IBOutlet private weak var passwordTextField: ClearableTextField!
    @IBOutlet private weak var deleteUsersButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    @IBAction private func saveButtonTapped() {
        
        if usernameTextField.text != "" && passwordTextField.text != "" {
            print("🟢 All fields are NOT emtpy")
        }
        
        if usernameTextField.text != "" && passwordTextField.text == "" {
            callSaveNewUserNameAlert(for: usernameTextField.text!)
        }
        
        if usernameTextField.text == "" && passwordTextField.text != "" {
            print("🔴 usernameTextField is emtpy")
        }
        
        if usernameTextField.text == "" && passwordTextField.text == "" {
            print("🟣 All fields are emtpy")
        }
    }
    
    @IBAction private func deleteUsersButtonTapped(_ sender: UIButton) {
        callDeleteAllUsersAlert()
    }
    
    private func configureView() {
        guard let loggedInAccount = AccountManager.loggedInAccount else { return }
        
        usernameLabel.text = loggedInAccount.username
        usernameTextField.text = loggedInAccount.username
        
        let adminIsConnected = loggedInAccount.accountType == .admin
        deleteUsersButton.isHidden = !adminIsConnected

    }

    private func callDeleteAllUsersAlert() {
        let alert = UIAlertController(
            title: "All not admin Users are about to delete !!!",
            message: "Are you sure you want to delete them all?",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete All", style: UIAlertAction.Style.default, handler: {_ in
            UserDefaultsManager.deleteAllNotAdminUsers()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func callSaveNewUserNameAlert(for name: String) {
        let alert = UIAlertController(
            title: "User name set to \(name) !!!",
            message: "Do you confirm that name ?",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: {_ in
            self.dismissSettingView()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func dismissSettingView() {
        dismiss(animated: true, completion: nil)
    }
}
