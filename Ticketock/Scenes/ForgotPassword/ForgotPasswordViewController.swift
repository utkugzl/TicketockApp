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
        
        resetPasswordButton.addTarget(self, action: #selector(didTapResetPasswordButton), for: .touchUpInside)
    }


    private func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [emailField])

        emailField.inputAccessoryView = keyboardToolbar
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        emailField.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top + 30,
                                     width: view.width - 40,
                                     height: 52)

        resetPasswordButton.frame = CGRect(x: 20,
                                  y: emailField.bottom + 15,
                                  width: view.width - 40,
                                  height: 52)

    }
}


// MARK: - Selectors

extension ForgotPasswordViewController {
    
    @objc func didTapResetPasswordButton() {
        guard let email = emailField.text, !email.isEmpty else { return }
        
        // TODO: - Email validation

    }
}
