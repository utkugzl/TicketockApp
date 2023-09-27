//
//  LoginViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 27.09.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password)
    
    private let loginButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private let createAccountButton = CustomButton(title: "New User? Create an Account", fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        
        return header
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    
    
    @objc private func didTabCreateAccountButton() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}

// MARK: - Configurations

extension LoginViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: view.height/3.0
        )
        
        configureHeaderView()
        
        emailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 15,
            width: view.width - 50,
            height: 52.0
        )
        
        passwordField.frame = CGRect(
            x: 25,
            y: emailField.bottom + 15,
            width: view.width - 50,
            height: 52.0
        )
        
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 15,
            width: view.width - 50,
            height: 52.0
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        forgotPasswordButton.frame = CGRect(
            x: 25,
            y: createAccountButton.bottom + 5,
            width: view.width - 50,
            height: 52.0
        )
    
    }
    
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        view.addSubview(forgotPasswordButton)
        
        //loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTabCreateAccountButton), for: .touchUpInside)
        
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [emailField, passwordField])
        
        [emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
  
    }
    
    
    private func configureHeaderView() {
        
        let imageView = UIImageView(image: UIImage(named: "loginHeader"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width,
                                 height: headerView.height - view.safeAreaInsets.top
        )
    }
}
