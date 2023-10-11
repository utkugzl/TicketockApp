//
//  LoginViewModel.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import Foundation
import UIKit


final class LoginViewModel {
    weak var view: LoginViewProtocol?
}


// MARK: - LoginViewModelProtocol

extension LoginViewModel: LoginViewModelProtocol {

    func viewDidLoad() {
        view?.configureUI()
        view?.configureToolBar()
    }
    
    func viewWillAppear() {
        view?.configureNavBar()
    }
    
    func didTapLoginButton(email: String, password: String) {
        
        let loginUserRequest = LoginUserModal(
            email: email ,
            password: password
        )
        
        // Email check
        if !ValidationManager.isValidEmail(for: loginUserRequest.email) {
            view?.showInvalidEmailAlert()
            return
        }
        
        // Password check
//        if !ValidateManager.isValidPassword(for: registerUserRequest.password) {
//            AlertManager.showInvalidPasswordAlert(on: self)
//            return
//        }
                
        AuthManager.shared.signIn(with: loginUserRequest) { result in
            switch result {
            case .success:
                AuthManager.shared.checkAuthentication()
            case .failure(let error):
                self.view?.showSignInErrorAlert(error: error)
            }
        }
    
    }
    
    func didTabCreateAccountButton() {
        let vc = RegisterViewController()
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTabForgotPasswordButton() {
        let vc = ForgotPasswordViewController()
        vc.title = "Forgot Password"
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
