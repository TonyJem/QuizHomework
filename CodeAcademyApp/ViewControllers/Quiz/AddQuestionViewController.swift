import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet private weak var questionDescriptionTextField: ClearableTextField!
    @IBOutlet private weak var firstAnswerTextField: ClearableTextField!
    @IBOutlet private weak var secondAnswerTextField: ClearableTextField!
    @IBOutlet private weak var thirdAnswerTextField: ClearableTextField!
    @IBOutlet private weak var fourthAnswerTextField: ClearableTextField!
    @IBOutlet private weak var correctAnswerTextField: ClearableTextField!

    @IBAction func submitButtonTapped(_ sender: Any) {
        addQuestionToDatabase()
        dismiss(animated: true)
    }
}

private extension AddQuestionViewController {
    
    var isAnswerValid: Bool {
        return
            correctAnswerTextField.text == firstAnswerTextField.text ||
            correctAnswerTextField.text == secondAnswerTextField.text ||
            correctAnswerTextField.text == thirdAnswerTextField.text ||
            correctAnswerTextField.text == fourthAnswerTextField.text
    }

    func addQuestionToDatabase() {
        guard let question = makeQuestion() else {
            return
        }
        UserDefaultsManager.saveQuestion(question)
    }
    
    func makeQuestion() -> Question? {
        guard isAnswerValid,
              let questionDescription = questionDescriptionTextField.text,
              let firstAnswer = firstAnswerTextField.text,
              let secondAnswer = secondAnswerTextField.text,
              let thirdAnswer = thirdAnswerTextField.text,
              let fourthAnswer = fourthAnswerTextField.text,
              let correctAnswer = correctAnswerTextField.text,
              !questionDescription.isEmpty,
              !firstAnswer.isEmpty,
              !secondAnswer.isEmpty,
              !thirdAnswer.isEmpty,
              !fourthAnswer.isEmpty,
              !correctAnswer.isEmpty
        else {
            return nil
        }
        return Question(
            questionDescription: questionDescription,
            firstAnswer: firstAnswer,
            secondAnswer: secondAnswer,
            thirdAnswer: thirdAnswer,
            fourthAnswer: fourthAnswer,
            correctAnswer: correctAnswer
        )
    }
}
