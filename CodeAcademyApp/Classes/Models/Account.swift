enum AccountType: Int, Codable {
    case admin
    case user
}

struct Account: Codable {
    
    let username: String
    var password: String
    var accountType: AccountType
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        
        if UserDefaultsManager.accounts?.isEmpty ?? true {
            accountType = .admin
        } else {
            accountType = .user
        }
    }
}
