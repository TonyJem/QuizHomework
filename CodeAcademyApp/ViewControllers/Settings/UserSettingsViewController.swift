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
    }
    
    @IBAction private func deleteUsersButtonTapped(_ sender: UIButton) {
        callDeleteAllUsersAlert()
    }
    
    private func configureView() {
        if let loggedInAccount = AccountManager.loggedInAccount {
            let adminIsConnected = loggedInAccount.accountType == .admin
            deleteUsersButton.isHidden = !adminIsConnected
        }
    }

    private func callDeleteAllUsersAlert() {
        let alert = UIAlertController(
            title: "All not admin Users are about to delete !!!",
            message: "Are you sure you want to delete them all?",
            preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Delete All", style: UIAlertAction.Style.default, handler: {_ in
            UserDefaultsManager.deleteAllNotAdminUsers()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
