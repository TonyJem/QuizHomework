//
//  UserDefaultManager.swift
//  CodeAcademyApp
//
//  Created by Vilius Bundulas on 2021-01-12.
//

import Foundation

struct UserDefaultsManager {
    
    private enum UserDefaultsManagerKey {
        static let quizQuestions = "QuizQuestions"
        static let accounts = "Accounts"
        static let pointsRules = "PointsRules"
        static let gameSaves = "GameSaves"
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
    
    private static func savePassword(_ password: String, username: String) {
        keyChain.set(password, forKey: username)
    }
    
    static func getPassword(username: String) -> String? {
        keyChain.get(username)
    }
}


