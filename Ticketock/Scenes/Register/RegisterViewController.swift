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
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    
    private func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [usernameField,emailField, passwordField])

        [usernameField, emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
    }
    
    
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


// MARK: - Selectors

extension RegisterViewController {
    
    @objc private func didTapRegisterButton() {
//        guard let username = usernameField.text, !username.isEmpty,
//              let email = emailField.text, !email.isEmpty,
//              let password = passwordField.text, !password.isEmpty else {
//            //presentAlertOnMainThread(title: "Empty Fields", message: "Please enter your email and password", buttonTitle: "Ok")
//            AlertManager.showInvalidUsernameAlert(on: self)
//            return
//        }
        
        let registerUserRequest = RegisterUserModal(
            username: usernameField.text ?? "",
            email: emailField.text ?? "",
            password: passwordField.text ?? ""
        )
        
        // Username check
        if !ValidationManager.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        // Email check
        if !ValidationManager.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        // Password check
//        if !ValidateManager.isValidPassword(for: registerUserRequest.password) {
//            AlertManager.showInvalidPasswordAlert(on: self)
//            return
//        }
        
        AuthManager.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
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


// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } // Diğer text field'larınız için aynı şekilde devam edin.
        
        return true
    }
}
