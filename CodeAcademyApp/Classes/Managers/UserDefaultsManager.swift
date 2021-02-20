import Foundation

struct UserDefaultsManager {
    
    private enum UserDefaultsManagerKey {
        static let quizQuestions = "QuizQuestions"
        static let accounts = "Accounts"
        static let pointsRules = "PointsRules"
        static let gameSaves = "GameSaves"
        static let currentUser = "CurrentUser"
    }
    
    private static var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    private static var keyChain: KeychainSwift {
        KeychainSwift()
    }

    static func saveQuestion(_ question: Question) {
        var savedQuestions = [Question]()
        
        if let questions = questions {
            savedQuestions = questions
        }
        savedQuestions.append(question)
        questions = savedQuestions
    }
    
    static func deleteAllQuestions() {
        guard questions != nil else { return }
        questions?.removeAll()
    }
    
    static func deleteAllNotAdminUsers() {
        guard accounts != nil else { return }
        accounts?.removeAll(where: {$0.accountType == .user})
    }
    
    static func deleteAccount(_ account: Account) {
        guard accounts != nil else { return }
        accounts?.removeAll(where: {$0.username == account.username})
    }
    
    static func saveAccount(_ account: inout Account) {
        var savedAccounts = [Account]()
        
        if let accounts = accounts {
            savedAccounts = accounts
        }
        savePassword(account.password, username: account.username)
        account.password = ""
        savedAccounts.append(account)
        accounts = savedAccounts 
    }
    
    static func saveGameSave(_ gameSave: GameSave) {
        var newGameSaves = [GameSave]()

        if let currentGameSaves = gameSaves {
            newGameSaves = currentGameSaves
        }
        newGameSaves.append(gameSave)
        gameSaves = newGameSaves
    }
 }

// MARK: - Helpers

extension UserDefaultsManager {
    
    static var pointsRules: Points? {
        get {
            guard let encodedPointsRules = userDefaults.object(forKey: UserDefaultsManagerKey.pointsRules) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(Points.self, from: encodedPointsRules)
        } set {
            let encodedPointsRules = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedPointsRules, forKey: UserDefaultsManagerKey.pointsRules)
        }
    }
    
    static var questions: [Question]? {
        get {
            guard let encodedQuestions = userDefaults.object(forKey: UserDefaultsManagerKey.quizQuestions) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode([Question].self, from: encodedQuestions)
        } set {
            let encodedQuestions = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedQuestions, forKey: UserDefaultsManagerKey.quizQuestions)
        }
    }
    
    static var accounts: [Account]? {
        get {
            guard let encodedAccounts = userDefaults.object(forKey: UserDefaultsManagerKey.accounts) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode([Account].self, from: encodedAccounts)
        } set {
            let encodedAccounts = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedAccounts, forKey: UserDefaultsManagerKey.accounts)
        }
    }
    
    static var gameSaves: [GameSave]? {
        get {
            guard let gameSaves = userDefaults.object(forKey: UserDefaultsManagerKey.gameSaves) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode([GameSave].self, from: gameSaves)
        } set {
            let gameSaves = try? JSONEncoder().encode(newValue)
            userDefaults.set(gameSaves, forKey: UserDefaultsManagerKey.gameSaves)
        }
    }
    
    static var currentUser: Account? {
        get {
            guard let currentUser = userDefaults.object(forKey: UserDefaultsManagerKey.currentUser) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(Account.self, from: currentUser)
        } set {
            let currentUser = try? JSONEncoder().encode(newValue)
            userDefaults.set(currentUser, forKey: UserDefaultsManagerKey.currentUser)
        }
    }
    
    private static func savePassword(_ password: String, username: String) {
        keyChain.set(password, forKey: username)
    }
    
    static func shuffleQuestions() {
        let shuffledQuestions = questions?.shuffled()
        questions = shuffledQuestions
    }
    
    static func getPassword(username: String) -> String? {
        keyChain.get(username)
    }
}


