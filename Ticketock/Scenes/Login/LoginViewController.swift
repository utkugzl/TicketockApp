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
    
    private let headerView = AuthHeaderView(title: "Sign In", subtitle: "Sign In to your account")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
}


// MARK: - Configurations

extension LoginViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        headerView.backgroundColor = .systemRed
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        view.addSubview(forgotPasswordButton)
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTabCreateAccountButton), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTabForgotPasswordButton), for: .touchUpInside)
  
    }
    
    private func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [emailField, passwordField])
        
        [emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: 270
        )
        
        emailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 120,
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

}

// MARK: - Selectors

extension LoginViewController {
    
    @objc private func didTapLoginButton() {
        let vc = ProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc private func didTabCreateAccountButton() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTabForgotPasswordButton() {
        let vc = ForgotPasswordViewController()
        vc.title = "Forgot Password"
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
}


