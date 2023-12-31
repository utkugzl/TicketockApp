//
//  AlertManager.swift
//  Ticketock
//
//  Created by Utku Güzel on 29.09.2023.
//

import UIKit

final class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            vc.present(alert, animated: true)
        }
    }
    
    private static func showBasicAlertWithHandler(on vc: UIViewController, title: String, leftButtonTitle: String, rightButtonTitle: String, message: String?, handler: ((UIAlertAction) -> Void)?) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: leftButtonTitle, style: .default))
            alert.addAction(UIAlertAction(title: rightButtonTitle, style: .destructive, handler: handler))
            
            vc.present(alert, animated: true)
        }
    }
}

// MARK: - Validation Alerts

extension AlertManager {
    
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email address.")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid Password", message: "The password must contain at least one lowercase letter, at least one special character.")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid Username", message: "The username must be between 4 and 24 characters in length and contain only letters and numbers.")
    }
}


// MARK: - Registration Alerts

extension AlertManager {
    
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Unknown Registration Error", message: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Unknown Registration Error", message: "\(error.localizedDescription)")
    }
}

// MARK: - Log In Alerts

extension AlertManager {
    
    public static func showSignInErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Unknown Error Signing In", message: nil)
    }
    
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Error Signing In", message: "\(error.localizedDescription)")
    }
}

// MARK: - Log Out Alerts

extension AlertManager {
    
    public static func showLogoutErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Log Out Error", message: "\(error.localizedDescription)")
    }
    
    public static func showLogOutAlert(on vc: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        showBasicAlertWithHandler(on: vc, title: "Log Out", leftButtonTitle: "Cancel", rightButtonTitle: "Log Out", message: "Are you sure you want to log out?", handler: handler)
    }
}

// MARK: - Forgot Password Alerts

extension AlertManager {
    
    public static func showPasswordResetSent(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Password Reset Sent", message: nil)
    }
    
    public static func showSendingPasswordResetErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Error Sending Password Reset", message: "\(error.localizedDescription)")
    }
}

// MARK: - Fetching User Alerts

extension AlertManager {
    
    public static func showUnknownFetchingUserError(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Unknown Error Fetching User", message: nil)
    }
    
    public static func showFetchingUserError(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
}

