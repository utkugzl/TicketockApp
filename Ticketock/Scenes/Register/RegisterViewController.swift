//
//  RegisterViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 27.09.2023.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func configureToolBar()
    func configureNavBar()
    func configureUI()
}

final class RegisterViewController: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Sign Up", subtitle: "Create your account")
    private let usernameField = CustomTextField(authFieldType: .username)
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password)
    private let termsTextView = CustomTermsAndPrivacyTextView()
    private let registerButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    
    private lazy var viewModal = RegisterViewModel()

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

extension RegisterViewController: RegisterViewProtocol {
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        view.addSubview(termsTextView)
        
        makeHeaderView()
        makeUsernameField()
        makeEmailField()
        makePasswordField()
        makeRegisterButton()
        makeTermsTextView()
          
        [usernameField, emailField, passwordField].forEach { $0.delegate = self }

        termsTextView.delegate = self
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [usernameField,emailField, passwordField])

        [usernameField, emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
    }
}


// MARK: - UITextViewDelegate

extension RegisterViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        viewModal.shouldInteractWith(url: URL)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
    
}


// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        
        return true
    }
}


// MARK: - Selectors

extension RegisterViewController {
    
    @objc private func didTapRegisterButton() {
        viewModal.didTapRegisterButton(username: usernameField.text ?? "",
                                       email: emailField.text ?? "",
                                       password: passwordField.text ?? "")
        
    }

}


// MARK: - Configure UI

extension RegisterViewController {
    
    private func makeHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 280),
        ])
    }
    private func makeUsernameField() {
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50),
            usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            usernameField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makeEmailField() {
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 15),
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
    private func makeRegisterButton() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 25),
            registerButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    private func makeTermsTextView() {
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termsTextView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 5),
            termsTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            termsTextView.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
 
}


