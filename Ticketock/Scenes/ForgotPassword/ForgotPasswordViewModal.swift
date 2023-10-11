//
//  ForgotPasswordViewModal.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import Foundation


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
        
        if !ValidationManager.isValidEmail(for: email) {
            view?.showInvalidEmailAlert()
            return
        }
        
        AuthManager.shared.forgotPassword(with: email) { result in
            switch result {
            case .success:
                self.view?.showPasswordResetSent()
            case .failure(let error):
                self.view?.showSendingPasswordResetErrorAlert(error: error)
            
            }
        }
    }
    
}

