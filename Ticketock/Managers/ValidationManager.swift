//
//  ValidateManager.swift
//  Ticketock
//
//  Created by Utku Güzel on 1.10.2023.
//

import Foundation


final class ValidationManager {
    
    static func isValidEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = AppConstants.Regex.emailRegex
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidUsername(for username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameRegex = AppConstants.Regex.usernameRegex
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        
        return usernamePredicate.evaluate(with: username)
    }
    
    static func isValidPassword(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegex = AppConstants.Regex.passwordRegex
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: password)
    }
}

