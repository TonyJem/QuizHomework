import UIKit

class ViewController: CodeAcademyViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        guard UserDefaultsManager.currentUser != nil else { return }
        proceedToQuizView()
    }
    
}
