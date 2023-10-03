//
//  ForgotPasswordViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 28.09.2023.
//

import UIKit

final class ForgotPasswordViewController: UIViewController {
    
    private let emailField = CustomTextField(authFieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Reset Password", hasBackground: true, fontSize: .big)
    

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


// MARK: - Configure UI

extension ForgotPasswordViewController {

    private func configureUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(emailField)
        view.addSubview(resetPasswordButton)

        makeEmailField()
        makeResetPasswordButton()
        
        resetPasswordButton.addTarget(self, action: #selector(didTapResetPasswordButton), for: .touchUpInside)
    }


    private func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [emailField])

        emailField.inputAccessoryView = keyboardToolbar
    }
    
    
    private func makeEmailField() {
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            emailField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makeResetPasswordButton() {
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            resetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}


// MARK: - Selectors

extension ForgotPasswordViewController {
    
    @objc func didTapResetPasswordButton() {
        let email = emailField.text ?? ""
        
        if !ValidationManager.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthManager.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self)
        }

    }
}
