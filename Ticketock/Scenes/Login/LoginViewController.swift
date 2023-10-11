//
//  LoginViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 27.09.2023.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func configureToolBar()
    func configureNavBar()
    func configureUI()
    func showSignInErrorAlert(error: Error)
    func showInvalidEmailAlert()
}

final class LoginViewController: UIViewController {
    
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password)
    private let loginButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private let createAccountButton = CustomButton(title: "New User? Create an Account", fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    private let headerView = AuthHeaderView(title: "Sign In", subtitle: "Sign In to your account")
    
    private lazy var viewModal = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModal.view = self
        viewModal.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModal.viewWillAppear()
    }
    
}

extension LoginViewController: LoginViewProtocol {
    
    func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [emailField, passwordField])
        
        [emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureUI() {
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
       
    }
    
    func showSignInErrorAlert(error: Error) {
        AlertManager.showSignInErrorAlert(on: self, with: error)
    }
    
    func showInvalidEmailAlert() {
        AlertManager.showInvalidEmailAlert(on: self)
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


// MARK: - Selectors

extension LoginViewController {
    
    @objc private func didTapLoginButton() {
        viewModal.didTapLoginButton(email: emailField.text ?? "", password: passwordField.text ?? "")
    }
    
    @objc private func didTabCreateAccountButton() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTabForgotPasswordButton() {
        viewModal.didTabForgotPasswordButton()
    }
    
}


// MARK: - Configure UI

extension LoginViewController {
    
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
            emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 140),
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
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    private func makeCreateAccountButton() {
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 5),
            createAccountButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            createAccountButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        createAccountButton.addTarget(self, action: #selector(didTabCreateAccountButton), for: .touchUpInside)
    }
    private func makeForgotPasswordButton() {
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        forgotPasswordButton.addTarget(self, action: #selector(didTabForgotPasswordButton), for: .touchUpInside)
    }

}



