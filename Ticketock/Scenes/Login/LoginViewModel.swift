//
//  LoginViewModel.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import Foundation
import UIKit


/*
protocol LoginViewModelProtocol {
    var view: LoginViewProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func didTapLoginButton(email: String, password: String)
}
 */

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
        guard let self = self.view as? LoginViewController else { return }
        
        let loginUserRequest = LoginUserModal(
            email: email ,
            password: password
        )
        
        // Email check
        if !ValidationManager.isValidEmail(for: loginUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
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
                AlertManager.showSignInErrorAlert(on: self, with: error)
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
