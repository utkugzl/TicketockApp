//
//  RegisterViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 27.09.2023.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Sign Up", subtitle: "Create your account")
    
    private let usernameField = CustomTextField(authFieldType: .username)
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password)
    private let termsTextView = CustomTermsAndPrivacyTextView()

    private let registerButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

}


//MARK: - Configurations

extension RegisterViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        headerView.backgroundColor = .systemRed
        
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
        
        termsTextView.delegate = self
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    
    }
    
    
    private func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [usernameField,emailField, passwordField])

        [usernameField, emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
    }
    
    private func makeHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 270),
        ])
    }
    private func makeUsernameField() {
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 120),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makeEmailField() {
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 15),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makePasswordField() {
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    private func makeRegisterButton() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 25),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    private func makeTermsTextView() {
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termsTextView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 5),
            termsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            termsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            termsTextView.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
 
}


// MARK: - Selectors

extension RegisterViewController {
    
    @objc private func didTapRegisterButton() {

    }

}


// MARK: - UITextViewDelegate

extension RegisterViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        guard let identifier = URL.scheme else { return false }
        
        switch identifier {
        case "terms":
            showWebViewerController(with: "https://policies.google.com/terms?hl=en")
            return false
        case "privacy":
            showWebViewerController(with: "https://policies.google.com/privacy?hl=en")
            return false
        default:
            return false
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
    
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewerController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    

}
