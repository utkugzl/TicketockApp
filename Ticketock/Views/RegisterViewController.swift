//
//  RegisterViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 27.09.2023.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let usernameField = CustomTextField(authFieldType: .username)
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password)

    private let registerButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

//MARK: - Configurations

extension RegisterViewController {
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [usernameField,emailField, passwordField])
        

        [usernameField, emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameField.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top + 30,
                                     width: view.width - 40,
                                     height: 52)
        
        emailField.frame = CGRect(x: 20,
                                  y: usernameField.bottom + 15,
                                  width: view.width - 40,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 20,
                                  y: emailField.bottom + 15,
                                  width: view.width - 40,
                                  height: 52)
        
        registerButton.frame = CGRect(x: 20,
                                     y: passwordField.bottom + 25,
                                     width: view.width - 40,
                                     height: 52)
    }
}

