//
//  ForgotPasswordViewModal.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import Foundation


protocol ForgotPasswordViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func didTapResetPasswordButton(email: String)
}

final class ForgotPasswordViewModel {
    weak var view: ForgotPasswordViewProtocol?
}


extension ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureUI()
        view?.configureToolBar()
    }
    
    func viewWillAppear() {
        view?.configureNavBar()
    }
    
    func didTapResetPasswordButton(email: String) {
        guard let self = self.view as? ForgotPasswordViewController else { return }
        
        if !ValidationManager.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthManager.shared.forgotPassword(with: email) { result in
            switch result {
            case .success:
                AlertManager.showPasswordResetSent(on: self)
            case .failure(let error):
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
            }
        }
    }
    
    
}

