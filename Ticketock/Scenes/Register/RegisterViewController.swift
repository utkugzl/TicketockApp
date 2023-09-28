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
        
        termsTextView.delegate = self
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    
    }
    
    
    private func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [usernameField,emailField, passwordField])

        [usernameField, emailField, passwordField].forEach { $0.inputAccessoryView = keyboardToolbar }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: 270
        )
        
        usernameField.frame = CGRect(x: 20,
                                     y: headerView.bottom + 120,
                                     width: view.width - 40,
                                     height: 52
        )
        
        
        emailField.frame = CGRect(x: 20,
                                  y: usernameField.bottom + 15,
                                  width: view.width - 40,
                                  height: 52
        )
        
        passwordField.frame = CGRect(x: 20,
                                  y: emailField.bottom + 15,
                                  width: view.width - 40,
                                  height: 52
        )
        
        registerButton.frame = CGRect(x: 20,
                                     y: passwordField.bottom + 25,
                                     width: view.width - 40,
                                     height: 52
        )
        
        termsTextView.frame = CGRect(x: 20,
                                     y: registerButton.bottom + 5,
                                     width: view.width - 40,
                                     height: 52
        )
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
