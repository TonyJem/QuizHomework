import UIKit

class ViewController: CodeAcademyViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        guard let currentUser = UserDefaultsManager.currentUser else { return }
        AccountManager.loggedInAccount = currentUser
        proceedToQuizView()
    }
    
}
