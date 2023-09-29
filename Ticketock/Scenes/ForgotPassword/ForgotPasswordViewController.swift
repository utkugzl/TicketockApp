//
//  ForgotPasswordViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 28.09.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
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


// MARK: - Configurations

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
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    private func makeResetPasswordButton() {
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            resetPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}


// MARK: - Selectors

extension ForgotPasswordViewController {
    
    @objc func didTapResetPasswordButton() {
        guard let email = emailField.text, !email.isEmpty else { return }
        
        // TODO: - Email validation

    }
}
