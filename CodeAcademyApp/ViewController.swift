import UIKit

class ViewController: CodeAcademyViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("🟢 VC loaded")
        
        guard let curentUser = UserDefaultsManager.currentUser else { return }
        
        print("🟢🟢🟢 curentUser in VC didDetected: \(curentUser)")
        proceedToQuizView()
    }
    
    
    
    @IBAction func loginButtonTApped(_ sender: UIButton) {
        
    }
    
}
