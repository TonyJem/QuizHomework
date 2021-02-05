struct QuizManager {
    
    static var quizState = QuizState()
    static var pointsRules: Points {
        UserDefaultsManager.pointsRules ?? Points(correctAnswer: 1, wrongAnswer: 1, timePenalty: 1)
    }
    
    static var firstQuizQuestion: Question? {
        quizState = QuizState()
        quizState.currentQuestionIndex = 0
        return loadQuestion(index: quizState.currentQuestionIndex)
       
    }
    
    static var nextQuizQuestion: Question? {
        quizState.currentQuestionIndex += 1
        return loadQuestion(index: quizState.currentQuestionIndex)
    }
    
    static func checkTheAnswer(answer: String) {
        let currentQuestion = loadQuestion(index: quizState.currentQuestionIndex)
        if currentQuestion?.correctAnswer == answer {
            quizState.points += pointsRules.correctAnswer
        } else {
            quizState.points -= pointsRules.wrongAnswer
            
        }
    }
    
    static func applyPenalty() {
        quizState.points -= pointsRules.timePenalty
    }
}

// MARK: - Helpers

extension QuizManager {
    
    private static func loadQuestion(index: Int) -> Question? {
        guard
            let questions = UserDefaultsManager.questions,
            index < questions.count
        else {
            return nil
        }
        return questions[index]
    }

    static func save() {
        let score = quizState.points
        guard let username = AccountManager.loggedInAccount?.username else { return }
        let gameSave = GameSave(username: username, score: score)
        UserDefaultsManager.saveGameSave(gameSave)
    }
}
