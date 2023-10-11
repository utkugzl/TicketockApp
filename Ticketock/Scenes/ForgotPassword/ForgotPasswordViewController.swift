//
//  ForgotPasswordViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 28.09.2023.
//

import UIKit

protocol ForgotPasswordViewProtocol: AnyObject {
    func configureUI()
    func configureToolBar()
    func configureNavBar()
    func showInvalidEmailAlert()
    func showPasswordResetSent()
    func showSendingPasswordResetErrorAlert(error: Error)
}

final class ForgotPasswordViewController: UIViewController {
    
    private let emailField = CustomTextField(authFieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Reset Password", hasBackground: true, fontSize: .big)
    
    private lazy var viewModal = ForgotPasswordViewModel()


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

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
    
    func configureUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(emailField)
        view.addSubview(resetPasswordButton)

        makeEmailField()
        makeResetPasswordButton()
        
    }

    func configureToolBar() {
        let keyboardToolbar = CustomKeyboardToolbar(textFields: [emailField])

        emailField.inputAccessoryView = keyboardToolbar
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func showInvalidEmailAlert() {
        AlertManager.showInvalidEmailAlert(on: self)
    }
    
    func showPasswordResetSent() {
        AlertManager.showPasswordResetSent(on: self)
    }
    
    func showSendingPasswordResetErrorAlert(error: Error) {
        AlertManager.showSendingPasswordResetErrorAlert(on: self, with: error)
    }
}


// MARK: - Selectors

extension ForgotPasswordViewController {
    
    @objc func didTapResetPasswordButton() {
        viewModal.didTapResetPasswordButton(email: emailField.text ?? "")
    }
    
}


// MARK: - Configure UI

extension ForgotPasswordViewController {
  
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
        resetPasswordButton.addTarget(self, action: #selector(didTapResetPasswordButton), for: .touchUpInside)
    }
}

