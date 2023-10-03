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

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        
        return true
    }
}


// MARK: - Configure UI

extension LoginViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        view.addSubview(forgotPasswordButton)
        
        makeHeaderView()
        makeEmailField()
        makePasswordField()
        makeLoginButton()
        makeCreateAccountButton()
        makeForgotPasswordButton()
        
        [emailField, passwordField].forEach { $0.delegate = self }
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTabCreateAccountButton), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTabForgotPasswordButton), for: .touchUpInside)
    }
    
    
    private func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [emailField, passwordField])
        
        [emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
    }
    
    
    private func makeHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 280),
        ])
    }
    private func makeEmailField() {
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 100),
            emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            emailField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makePasswordField() {
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makeLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makeCreateAccountButton() {
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 5),
            createAccountButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            createAccountButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makeForgotPasswordButton() {
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

}


// MARK: - Selectors

extension LoginViewController {
    
    @objc private func didTapLoginButton() {
//        guard let email = emailField.text, !email.isEmpty,
//              let password = passwordField.text, !password.isEmpty else {
//            //presentAlertOnMainThread(title: "Empty Fields", message: "Please enter your email and password", buttonTitle: "Ok")
//            return
//        }
        
        let loginUserRequest = LoginUserModal(
            email: emailField.text ?? "",
            password: passwordField.text ?? ""
        )
        
        // Email check
        if !ValidationManager.isValidEmail(for: loginUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        // Password check
//        if !ValidateManager.isValidPassword(for: registerUserRequest.password) {
//            AlertManager.showInvalidPasswordAlert(on: self)
//            return
//        }
        
        AuthManager.shared.signIn(with: loginUserRequest) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            } else {
                AlertManager.showSignInErrorAlert(on: self)
            }
        }
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


